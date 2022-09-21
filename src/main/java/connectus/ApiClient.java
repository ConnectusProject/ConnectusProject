/*
 * @(#)ApiClient.java $version 2017. 5. 19.
 *
 * Copyright 2007 NHN Corp. All rights Reserved.
 * NHN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package connectus;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.SortedMap;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;

public class ApiClient {
	private final String accessKey;
	private final String secretKey;
	private final CloseableHttpClient httpClient;

	public ApiClient(final String accessKey, final String secretKey) {
		
		
		this.accessKey = geoapiignore.geoaccess;
		this.secretKey = geoapiignore.geosecret;

		final int timeout = 5000;
		final RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(timeout).setConnectTimeout(timeout).build();
		httpClient = HttpClientBuilder.create().setDefaultRequestConfig(requestConfig).build();
	}

	public static void main(final String[] args) {
		if (args.length != 3) {
			System.out.println("Usage : accessKey secretKey ip");
			return;
		}

		try {
			/** args[0] => accessKey, args[1] => secretKey, args[2] => IP, **/
			System.out.println(args[0] + args[1] + args[2]);
			final ApiClient apiClient = new ApiClient(args[0], args[1]);
			apiClient.run(args[2]);
		} catch (final Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public String run(final String ip) throws Exception {
		final String requestMethod = "GET";
		final String hostName = "https://geolocation.apigw.ntruss.com";
		final String requestUrl= "/geolocation/v2/geoLocation";
		
		final Map<String, List<String>> requestParameters = new HashMap<String, List<String>>();
		requestParameters.put("ip", Arrays.asList(ip));
		requestParameters.put("ext", Arrays.asList("t"));
		requestParameters.put("responseFormatType", Arrays.asList("json"));
		
		SortedMap<String, SortedSet<String>> parameters = convertTypeToSortedMap(requestParameters);
		
		String timestamp = generateTimestamp();
		System.out.println("timestamp: " + timestamp);

		String baseString = requestUrl + "?" + getRequestQueryString(parameters);
		System.out.println("baseString : " + baseString);
		
		String signature = makeSignature(requestMethod, baseString, timestamp, accessKey, secretKey);
		System.out.println("signature : " + signature);
		
		final String requestFullUrl = hostName + baseString;
		final HttpGet request = new HttpGet(requestFullUrl);
		request.setHeader("x-ncp-apigw-timestamp",timestamp);
		request.setHeader("x-ncp-iam-access-key",accessKey);
		request.setHeader("x-ncp-apigw-signature-v2",signature);
		
		final CloseableHttpResponse response;
		response = httpClient.execute(request);

		final String msg = getResponse(response);
		System.out.println("이게 결과 : " + msg);
		return msg;
	}

	private String getResponse(final CloseableHttpResponse response) throws Exception {
		final StringBuffer buffer = new StringBuffer();
		final BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));

		String msg;

		try {
			while ((msg = reader.readLine()) != null) {
				buffer.append(msg);
			}
		} catch (final Exception e) {
			throw e;
		} finally {
			response.close();
		}
		return buffer.toString();
	}


	/**
	 * @param requestParameters
	 * @param significateParameters
	 */
	private static SortedMap<String, SortedSet<String>> convertTypeToSortedMap(final Map<String, List<String>> requestParameters) {
		final SortedMap<String, SortedSet<String>> significateParameters = new TreeMap<String, SortedSet<String>>();
		final Iterator<String> parameterNames = requestParameters.keySet().iterator();
		while (parameterNames.hasNext()) {
			final String parameterName = parameterNames.next();
			List<String> parameterValues = requestParameters.get(parameterName);
			if (parameterValues == null) {
				parameterValues = new ArrayList<String>();
			}

			for (String parameterValue : parameterValues) {
				if (parameterValue == null) {
					parameterValue = "";
				}

				SortedSet<String> significantValues = significateParameters.get(parameterName);
				if (significantValues == null) {
					significantValues = new TreeSet<String>();
					significateParameters.put(parameterName, significantValues);
				}
				significantValues.add(parameterValue);
			}

		}
		return significateParameters;
	}

	private static String generateTimestamp() {
		return Long.toString(System.currentTimeMillis());
	}

	/**
	 * query string 생성
	 * @param significantParameters
	 * @return
	 */
	private static String getRequestQueryString(final SortedMap<String, SortedSet<String>> significantParameters) {
		final StringBuilder queryString = new StringBuilder();
		final Iterator<Map.Entry<String, SortedSet<String>>> paramIt = significantParameters.entrySet().iterator();
		while (paramIt.hasNext()) {
			final Map.Entry<String, SortedSet<String>> sortedParameter = paramIt.next();
			final Iterator<String> valueIt = sortedParameter.getValue().iterator();
			while (valueIt.hasNext()) {
				final String parameterValue = valueIt.next();
				
				queryString.append(sortedParameter.getKey()).append('=').append(parameterValue);
				
				if (paramIt.hasNext() || valueIt.hasNext()) {
					queryString.append('&');
				}
			}
		}
		return queryString.toString();
		
	}	


	/**
	 * * base string과 timestamp, access key, secret key를 가지고 signature 생성
	 * @param method
	 * @param baseString
	 * @param timestamp
	 * @param accessKey
	 * @param secretKey
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 * @throws InvalidKeyException
	 */
	public String makeSignature(final String method, final String baseString, final String timestamp, final String accessKey, final String secretKey) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException{
	    String space = " ";                       // one space
	    String newLine = "\n";                    // new line

	    String message = new StringBuilder()
	        .append(method)
	        .append(space)
	        .append(baseString)
	        .append(newLine)
	        .append(timestamp)
	        .append(newLine)
	        .append(accessKey)
	        .toString();

	    SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
		Mac mac = Mac.getInstance("HmacSHA256");
	    mac.init(signingKey);
	    byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
	    String encodeBase64String = Base64.encodeBase64String(rawHmac);
	    return encodeBase64String;
	}
}
