package connectus.product;


import java.io.File;
import java.io.IOException;
import java.net.http.HttpRequest;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import connectus.ApiClient;
import connectus.geoapiignore;
import connectus.member.MemberDAO;
import connectus.reservation.ReservationDTO;


@Controller
public class ProductController {

	
	@Autowired
	ProductDAO productDAO;
	
	@Autowired
	MemberDAO memberDAO; 
	
	
	// 홈 
	@GetMapping("/")
	public String home() {
		return "home";
	}

	// 전체 물품 조회
	@GetMapping("/allproduct")
	public String allProduct(Model model, HttpSession session) throws Exception {
		String sessionid = (String)session.getAttribute("sessionid");
		String extraaddr = memberDAO.getRegion(sessionid);
		String region = "동"; 
		if(extraaddr != null) {
		region = extraaddr.substring(2,extraaddr.length()-1); }
		
		List<ProductDTO> list = productDAO.allProduct();
		
		
		// 찜 set 
		for (ProductDTO dto : list) {
			int productseq = (int)dto.getId();
			
			int zzim = 0; 
			Object zzimcheck = productDAO.zzimCount(productseq, sessionid);
			if(zzimcheck!=null) {
				zzim = 1; 
			}
			
			dto.setZzim(zzim);
		}
		
		int productlength = list.size();
		
	
		model.addAttribute("region", region);
		model.addAttribute("productlength", productlength);
		model.addAttribute("allproduct", list);
		return "product/allProduct";
	}
	
	
	// 검색
	@GetMapping("/searchproduct")
	public String searchList(String item, String search, HttpSession session ,Model model) throws Exception {
		
		String sessionid = (String)session.getAttribute("sessionid");
		String extraaddr = memberDAO.getRegion(sessionid);
		String region = "동"; 
		if(extraaddr != null) {
		region = extraaddr.substring(2,extraaddr.length()-1); }
		

		HashMap<String, String> map = new HashMap<>();
		map.put("item", item);
		map.put("search", search);

		List<ProductDTO> searchList = productDAO.searchList(map);
		
		// 찜 set 
				for (ProductDTO dto : searchList) {
					int productseq = (int)dto.getId();
					
					int zzim = 0; 
					Object zzimcheck = productDAO.zzimCount(productseq, sessionid);
					if(zzimcheck!=null) {
						zzim = 1; 
					}
					
					dto.setZzim(zzim);
				}
				
				int productlength = searchList.size();
		model.addAttribute("region", region);
		model.addAttribute("productlength", productlength);
		model.addAttribute("searchList", searchList);
		return "product/searchList";
	}
	
	// 스마트검색 
	@PostMapping("/smartSearch")
	public String smartSearch(SmartSearchDTO smartSearchDTO, Model model, HttpSession session) throws Exception {
		String sessionid = (String)session.getAttribute("sessionid");
		String extraaddr = memberDAO.getRegion(sessionid);
		String region = "동"; 
		if(extraaddr != null) {
		region = extraaddr.substring(2,extraaddr.length()-1); }
		
		
		List<ProductDTO> searchList = productDAO.smartSearch(smartSearchDTO);

		System.out.println(smartSearchDTO.toString());
		
		// 찜 set 
		for (ProductDTO dto : searchList) {
			int productseq = (int)dto.getId();
			
			int zzim = 0; 
			Object zzimcheck = productDAO.zzimCount(productseq, sessionid);
			if(zzimcheck!=null) {
				zzim = 1; 
			}
			
			dto.setZzim(zzim);
		}
		
			int productlength = searchList.size();
		model.addAttribute("region", region);
		model.addAttribute("productlength", productlength);
		model.addAttribute("searchList", searchList);
		
		return "product/smartSearch";
	}
	
	
	
	// 내 이웃 
		@GetMapping("/neighbor")
		public String neighborList(String item, String search, HttpSession session ,Model model) throws Exception {
			
			String sessionid = (String)session.getAttribute("sessionid");
			String extraaddr = memberDAO.getRegion(sessionid);
			String region = "동"; 
			if(extraaddr != null) {
			region = extraaddr.substring(2,extraaddr.length()-1); }
			

			List<ProductDTO> searchList = productDAO.neighborList(region);
			
			// 찜 set 
					for (ProductDTO dto : searchList) {
						int productseq = (int)dto.getId();
						
						int zzim = 0; 
						Object zzimcheck = productDAO.zzimCount(productseq, sessionid);
						if(zzimcheck!=null) {
							zzim = 1; 
						}
						
						dto.setZzim(zzim);
					}
					
					int productlength = searchList.size();
			model.addAttribute("region", region);
			model.addAttribute("productlength", productlength);
			model.addAttribute("searchList", searchList);
			return "product/neighbor";
		}
	
	
	
	
	
	
	
	
	// 물품 상세페이지 
	@GetMapping("/product/{productid}")
	public String oneProduct(@PathVariable("productid")int productid, Model model, HttpSession session) throws Exception {
		
		String sessionid = (String)session.getAttribute("sessionid");
		
		
		ProductDTO targetProduct = productDAO.oneProduct(productid);
		
		
		Object zzimcheck = productDAO.zzimCount(productid, sessionid);
		
		int zzim = 0 ; 
		if(zzimcheck!=null) {
			zzim = 1; 
		}
		
		targetProduct.setZzim(zzim);
		
		List<ReservationDTO> reservList = productDAO.allReservation(productid);
		int reservLength = reservList.size();
		
		model.addAttribute("reservLength", reservLength);
		model.addAttribute("reservationList", reservList);
		model.addAttribute("oneProduct", targetProduct);

		return "product/oneProduct";
	}
	
	
	//글작성 폼 
	@GetMapping("/registerProduct")
	public String registerProduct(HttpSession session, Model model) {
		String sessionid = (String)session.getAttribute("sessionid");
		String extraaddr = memberDAO.getRegion(sessionid);
		String region = extraaddr.substring(2,extraaddr.length()-1);
		model.addAttribute("region", region);
		
		return "product/insertProductForm";
	}
	
	// 글작성 
	@PostMapping("/registerProduct")
	public String registerProcess(ProductDTO dto, UploadDTO uploaddto) throws Exception{
		
		// 이미지 Set 
		if(uploaddto.getFile1()!=null) {
				dto.setImg1(uploaddto.getFile1());
		}
		if(uploaddto.getFile2()!=null) {
			dto.setImg2(uploaddto.getFile2());
		}
		if(uploaddto.getFile3()!=null) {
			dto.setImg3(uploaddto.getFile3());
		}
		if(uploaddto.getFile4()!=null) {
			dto.setImg4(uploaddto.getFile4());
		}
		if(uploaddto.getFile5()!=null) {
			dto.setImg5(uploaddto.getFile5());
		}
		if(uploaddto.getFile6()!=null) {
			dto.setImg6(uploaddto.getFile6());
		}
				
		// 지역 이름 set 	( 이거 동네는 매번 위치를 킬 수 없으니까 회원가입할 때, 혹은 기간에 한번씩만 인증하는식으로 받아서 DTO 에 넣어두고 사용하자 )
//			ApiClient apiClient = new ApiClient(geoapiignore.geoaccess, geoapiignore.geosecret);
//			
//			String geo = apiClient.run(geoapiignore.geoip);
//			
//			int index = geo.indexOf("r3");
//			int index2 = geo.indexOf("lat");
//			
//			String region = geo.substring(index+6, index2-3);
//			System.out.println(region);
//			
//			dto.setBoardRegion(region); 
			
			productDAO.insertProduct(dto);
		return "redirect:/allproduct";
	}
	
	// 이미지 미리보기 
	@ResponseBody
	@PostMapping(value ="/ajaxUpload", produces= {"application/json; charset=utf-8"})
	public String uploadajax(MultipartFile imgFile) throws IOException {
		
		String savePath = "/Users/youngban/upload/";
//		String savePath = "c:/upload/";					

		String originalname1 = imgFile.getOriginalFilename();
		String onlyfilename = originalname1.substring(0, originalname1.indexOf("."));
		String extname = originalname1.substring(originalname1.indexOf("."));
		String newname = onlyfilename + "(" + UUID.randomUUID().toString()+")" + extname;
		File serverfile1 = new File(savePath + newname);
		imgFile.transferTo(serverfile1);

		return "{\"result\" : \"" + newname + "\" }";
	}

	
	
	
	
	// 글삭제 
	@PostMapping("/product/{productid}/delete")
	public String deleteProduct(@PathVariable("productid")int productid) {
		productDAO.deleteProduct(productid);
		return "redirect:/allproduct";
	}
	
	
	// 글수정
	@GetMapping("/product/{productid}/update")
	public String updateProduct(@PathVariable("productid")int productid, Model model) {
		model.addAttribute("updateProduct", productDAO.oneProduct(productid));
		return "product/updateProductForm";
	}

	@PostMapping("/product/{productid}/updateprocess")
	public String updateProductProcess(@PathVariable("productid")int productid,ProductDTO productDTO, UploadDTO uploaddto) throws IllegalStateException, IOException {
		// update 할 아이디 set 
		productDTO.setId(productid);
		
		// 이미지 다시 Set 
	if(uploaddto.getFile1()!=null) {
		productDTO.setImg1(uploaddto.getFile1());
	}
	if(uploaddto.getFile2()!=null) {
		productDTO.setImg2(uploaddto.getFile2());
	}
	if(uploaddto.getFile3()!=null) {
		productDTO.setImg3(uploaddto.getFile3());
	}
	if(uploaddto.getFile4()!=null) {
		productDTO.setImg4(uploaddto.getFile4());
	}
	if(uploaddto.getFile5()!=null) {
		productDTO.setImg5(uploaddto.getFile5());
	}
	if(uploaddto.getFile6()!=null) {
		productDTO.setImg6(uploaddto.getFile6());
	}
	
		
		// update 실행 
		int updateResult = productDAO.updateProduct(productDTO);
		
		return "redirect:/allproduct";
	}

	
	// 찜 
		@ResponseBody
		@PostMapping("/product/zzim")
		public String updatezzim(int productseq, String memberid) throws Exception {
			

			int zzimCheck = productDAO.zzimCheck(productseq, memberid);
			if (zzimCheck == 0) {
				productDAO.insertZzim(productseq, memberid);
				productDAO.updateZzim(productseq, memberid);
			} else if (zzimCheck == 1) {
				productDAO.updateZzimCancel(productseq, memberid);
				productDAO.deleteZzim(productseq, memberid);
			}
			
			ProductDTO oneProduct = productDAO.oneProduct(productseq);

			return "{\"result\" : \"" + zzimCheck + "\", \"oneProduct\" : \"" + oneProduct + "\" }";
		}

		
	
	
	
	

	//
}
