package connectus.product;


import java.io.File;
import java.io.IOException;
import java.net.http.HttpRequest;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
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
import connectus.reservation.ReservationDAO;
import connectus.reservation.ReservationDTO;
import connectus.reservation.ReservationService;


@Controller
public class ProductController {
	@Autowired
	ProductDAO productDAO;
	@Autowired
	MemberDAO memberDAO; 
	@Autowired
	ReservationDAO reservationDAO;
	@Autowired
	ReservationService reservationService;
	@Autowired
	ProductService productService;
	
	// 홈 
	@GetMapping("/")
	public String home() {
		return "home";
	}

	// 물품 조회
	@GetMapping("/allproduct/{searchType}/{orderType}")
	public String allProduct(Model model, HttpSession session, String item, String search, @PathVariable("searchType")int searchType, @PathVariable("orderType")int orderType) throws Exception {
		// 지역 set 
		String sessionid = (String)session.getAttribute("sessionid");
		String extraaddr = memberDAO.getRegion(sessionid);
		String region = "동"; 
		if(extraaddr != null) {
		region = extraaddr.substring(2,extraaddr.length()-1); }
		

		List<ProductDTO> list = new ArrayList<>();
		
		// 조회 Type set ( 1 = 전체 | 2 = nav검색 | 3 = 내동네 검색 ) 
		if(searchType==1) {
			if(orderType==1) {
		list = productService.allProduct(); 
		model.addAttribute("searchType", 1);
		model.addAttribute("orderType", 1);
			}
			else if(orderType==2) {
		list = productService.allProductOrderByLowPrice();
		model.addAttribute("searchType",1);
		model.addAttribute("orderType", 2);
			}
			else if(orderType==3) {
		list = productService.allProductOrderByHighPrice();
		model.addAttribute("searchType",1);
		model.addAttribute("orderType", 3);
			}
			else if(orderType==4) {
		list = productService.allProductOrderByCount();
		model.addAttribute("searchType", 1);
		model.addAttribute("orderType", 4);
			}
		}
		
		else if (searchType==2) {
			// 검색어 순위 
			
			if(search!=null && !search.isBlank() && !search.isEmpty()) {
			if(productService.searchCheck(search)==0) {
				productService.insertSearch(search);
			}else if(productService.searchCheck(search)>0) {
				productService.updateSearchCount(search);
			}
			}
			
			if(orderType==1) {
				list = productService.navSearch(search, 0);
				model.addAttribute("search", search);
				model.addAttribute("searchType", 2); 
				model.addAttribute("orderType", 1);
			}
			else if(orderType==2) {
				list = productService.navSearchOrderByLowPrice(search, 0);
				model.addAttribute("search", search);
				model.addAttribute("searchType", 2); 
				model.addAttribute("orderType", 2);
			}
			else if(orderType==3) {
				list = productService.navSearchOrderByHighPrice(search, 0);
				model.addAttribute("search", search);
				model.addAttribute("searchType", 2); 
				model.addAttribute("orderType", 3);
				}
			else if(orderType==4) {
				list = productService.navSearchOrderByCount(search, 0);
				model.addAttribute("search", search);
				model.addAttribute("searchType", 2); 
				model.addAttribute("orderType", 4);
				}
		}
	
		else if (searchType==3) {
			if(orderType==1) {
				list = productService.neighborList(region, 0);
				model.addAttribute("searchType", 3);
				model.addAttribute("orderType", 1);
			}else if(orderType==2) {
				list = productService.neighborListOrderByLowPrice(region, 0);
				model.addAttribute("searchType", 3);
				model.addAttribute("orderType", 2);
			}else if(orderType==3) {
				list = productService.neighborListOrderByHighPrice(region, 0);
				model.addAttribute("searchType", 3);
				model.addAttribute("orderType", 3);
			}else if(orderType==4) {
				list = productService.neighborListOrderByCount(region, 0);
				model.addAttribute("searchType", 3);
				model.addAttribute("orderType", 4);
			}
		}
		
		
		// 찜 set 
		for (ProductDTO dto : list) {
			int productseq = (int)dto.getId();
			
			int zzim = 0; 
			Object zzimcheck = productService.zzimCount(productseq, sessionid);
			if(zzimcheck!=null) {
				zzim = 1; 
			}
			
			dto.setZzim(zzim);
			
			// 렌탈중 표시 set ( 조회하는 시점에서 확인 ) 
			List<ReservationDTO> reservations = reservationService.getReservationDate(productseq);
			
			// 승낙된 예약이 하나도 없을 때, reservedNow=0 ( List index 개수가 없으므로 따로 처리 ) 
			if(reservations.size()==0) {
				productService.cancleReservation(productseq);
			}
			
			LocalDate now = LocalDate.now();
			int checkReserved = 0;
			for(int i = 0; i<reservations.size(); i++) {
				String startDateString = reservations.get(i).getStartRental();
				String endDateString = reservations.get(i).getEndRental();
				
				LocalDate start2 = LocalDate.of(Integer.parseInt(startDateString.substring(0,4)), Integer.parseInt(startDateString.substring(5,7)), Integer.parseInt(startDateString.substring(8,10)));
				LocalDate end2 = LocalDate.of(Integer.parseInt(endDateString.substring(0,4)), Integer.parseInt(endDateString.substring(5,7)), Integer.parseInt(endDateString.substring(8,10)));
				
				if( (now.isEqual(start2) || now.isAfter(start2)) && (now.isEqual(end2) || now.isBefore(end2))) {
					productService.checkReservation(productseq);
					checkReserved = 1;
				}else if(checkReserved != 1) {
					productService.cancleReservation(productseq);
					checkReserved = 0;
				}
			} // inner for 
		} //  outer for 
		
		// 상품개수 
		int productlength = list.size();
		// 찜목록 리스트   
		List<ProductDTO> zzimProducts = productService.getZzimProducts(sessionid);
		// 검색랭킹 
		List<String> searchLankingList = productService.searchLanking();
		
		model.addAttribute("searchLankingList", searchLankingList);
		model.addAttribute("zzimProducts", zzimProducts);
		model.addAttribute("region", region);
		model.addAttribute("productlength", productlength);
		model.addAttribute("allproduct", list);
		return "product/allProduct";
	}
		
	
	// 물품 조회 별 스크롤 AJAX 
		@ResponseBody
		@PostMapping("/allproduct/ajax/{searchType}/{orderType}")
		public List<ProductDTO> scrollProduct(Model model, HttpSession session, SmartSearchDTO smartSearchDTO, String item, String search, String scrollCount, String distanceKm, @PathVariable("searchType")int searchType, @PathVariable("orderType")int orderType) throws Exception {
			int limit = Integer.parseInt(scrollCount)*20;
			
			// 지역 set 
			String sessionid = (String)session.getAttribute("sessionid");
			String extraaddr = memberDAO.getRegion(sessionid);
			String region = "동"; 
			if(extraaddr != null) {
			region = extraaddr.substring(2,extraaddr.length()-1); }

			List<ProductDTO> list = new ArrayList<>();
			
			// 조회 Type set ( 1 = 전체 | 2 = nav검색 | 3 = 내동네 검색 | 4 = 스마트 검색 ) 
			if(searchType ==1) {
				if(orderType == 1) {
			list = productService.scrollProduct(limit); 
			} else if(orderType == 2 ) {
			list = productService.scrollProductOrderByLowPrice(limit);
			} else if(orderType == 3) {
			list = productService.scrollProductOrderByHighPrice(limit);	
			} else if(orderType == 4) {
			list = productService.scrollProductOrderByCount(limit);
			}
			}
			else if (searchType==2) {
				if(orderType == 1) {
			list = productService.navSearch(search, limit);
			}else if(orderType == 2) {
			list = productService.navSearchOrderByLowPrice(search, limit);	
			}else if(orderType == 3) {
			list = productService.navSearchOrderByHighPrice(search, limit);	
			}else if(orderType == 4) {
			list = productService.navSearchOrderByCount(search, limit);	
			}
			}	
			else if (searchType==3) {
				if(orderType==1) {
				list = productService.neighborList(region, limit);
			}else if(orderType==2) {
				list = productService.neighborListOrderByLowPrice(region, limit);
			}else if(orderType==3) {
				list = productService.neighborListOrderByHighPrice(region, limit);
			}else if(orderType==4) {
				list = productService.neighborListOrderByCount(region, limit);
			}
			}
			else if (searchType==4) {
				
				// 가격 세팅 
				if(smartSearchDTO.getSmartPriceMax()=="") {
					smartSearchDTO.setSmartPriceMax("100000000");  }
				if(smartSearchDTO.getSmartPriceMin()=="") {
					smartSearchDTO.setSmartPriceMin("0"); }
				
				
				// 제목,지역,가격 으로 검색한 상품리스트
				List<Integer> titleRegion = productService.searchByTitle_Region(smartSearchDTO.getSmartTitle(), smartSearchDTO.getSmartRegion(),smartSearchDTO.getSmartPriceMin(), smartSearchDTO.getSmartPriceMax(), limit);
				
				
				if(distanceKm!=null && (distanceKm.equals("5") || distanceKm.equals("15"))) {
					return null;
				}
				
				ArrayList<Integer> selectedList = new ArrayList<>();
				
				// 날짜로 검색 : 해당 날짜 조건에 부합하지 않는다 => 예약이 null 값인 것과, 예약수락이 없는 리스트까지 포함됨 
				for(int i = 0; i<titleRegion.size(); i++) {

				if(smartSearchDTO.getSmartStartDate() != "" && smartSearchDTO.getSmartEndDate() != "") {
				Integer selected =  productService.searchByRentalDate(smartSearchDTO.getSmartStartDate(), smartSearchDTO.getSmartEndDate(), titleRegion.get(i));
				
				if(selected>0) {
				selectedList.add(selected);  
					}
				}else if(smartSearchDTO.getSmartStartDate() == "" && smartSearchDTO.getSmartEndDate() == "") {
					selectedList.add(titleRegion.get(i));
					}
				} //for 
				
				// 찾은 상품 번호로 상품 list 를 불러옴 
				for(int i = 0; i < selectedList.size(); i++) {
				ProductDTO searchedOne = productService.oneProduct(selectedList.get(i));
				list.add(searchedOne);
				}
			}
			
			// 찜 set 
			for (ProductDTO dto : list) {
				int productseq = (int)dto.getId();
				
				int zzim = 0; 
				Object zzimcheck = productService.zzimCount(productseq, sessionid);
				if(zzimcheck!=null) {
					zzim = 1; 
				}
				
				dto.setZzim(zzim);
				
				// 렌탈중 표시 set ( 조회하는 시점에서 확인 ) 
				List<ReservationDTO> reservations = reservationService.getReservationDate(productseq);
				
				// 승낙된 예약이 하나도 없을 때, reservedNow=0 ( List index 개수가 없으므로 따로 처리 ) 
				if(reservations.size()==0) {
					productService.cancleReservation(productseq);
				}
				
				LocalDate now = LocalDate.now();
				int checkReserved = 0;
				for(int i = 0; i<reservations.size(); i++) {
					String startDateString = reservations.get(i).getStartRental();
					String endDateString = reservations.get(i).getEndRental();
					
					LocalDate start2 = LocalDate.of(Integer.parseInt(startDateString.substring(0,4)), Integer.parseInt(startDateString.substring(5,7)), Integer.parseInt(startDateString.substring(8,10)));
					LocalDate end2 = LocalDate.of(Integer.parseInt(endDateString.substring(0,4)), Integer.parseInt(endDateString.substring(5,7)), Integer.parseInt(endDateString.substring(8,10)));
					
					if( (now.isEqual(start2) || now.isAfter(start2)) && (now.isEqual(end2) || now.isBefore(end2))) {
						productService.checkReservation(productseq);
						checkReserved = 1;
					}else if(checkReserved != 1) {
						productService.cancleReservation(productseq);
						checkReserved = 0;
					}
				} // inner for 
			} //  outer for 
			return list;
		}
	

		
	// 스마트검색 
	@PostMapping("/smartSearch")
	public String smartSearch(SmartSearchDTO smartSearchDTO, Model model, HttpSession session, String distanceKm) throws Exception {
		String sessionid = (String)session.getAttribute("sessionid");
		String extraaddr = memberDAO.getRegion(sessionid);
		String region = "동"; 
		if(extraaddr != null) {
		region = extraaddr.substring(2,extraaddr.length()-1); }
		
		if(smartSearchDTO.getSmartRegion()==null) {
			smartSearchDTO.setSmartRegion("동");
		}
		
		// 검색어 순위 반영
		if(smartSearchDTO.getSmartTitle()!=null && !smartSearchDTO.getSmartTitle().isBlank() && !smartSearchDTO.getSmartTitle().isEmpty()) {
		String search = smartSearchDTO.getSmartTitle();
		if(productService.searchCheck(search)==0) {
			productService.insertSearch(search);
		}else if(productService.searchCheck(search)>0) {
			productService.updateSearchCount(search);
		}
		}
		
		// 제목,지역, 가격으로 검색한 상품리스트
		List<Integer> titleRegion = new ArrayList<>();

		
		// 가격 세팅 
		if(smartSearchDTO.getSmartPriceMax()=="") {
			smartSearchDTO.setSmartPriceMax("100000000");  }
		if(smartSearchDTO.getSmartPriceMin()=="") {
			smartSearchDTO.setSmartPriceMin("0"); }
		
		
		if(distanceKm==null) {
				titleRegion = productService.searchByTitle_Region(smartSearchDTO.getSmartTitle(), smartSearchDTO.getSmartRegion(), smartSearchDTO.getSmartPriceMin(), smartSearchDTO.getSmartPriceMax(), 0);}

		// 거리 
		ArrayList<Integer> innerDistanceIdList = new ArrayList<>();
			if(distanceKm!=null && (distanceKm.equals("5") || distanceKm.equals("15"))) {
				int intKm = Integer.parseInt(distanceKm);
				
				titleRegion = productService.NoLimitTitle_Region(smartSearchDTO.getSmartTitle(), smartSearchDTO.getSmartPriceMin(), smartSearchDTO.getSmartPriceMax());
				
				for(int i=0; i<titleRegion.size(); i++) {
						Integer innerDistanceId = productService.searchByDistance(sessionid, productService.oneProduct(titleRegion.get(i)).getUserId(), intKm );
						if(innerDistanceId>0 && !innerDistanceIdList.contains(innerDistanceId)) {
						innerDistanceIdList.add(innerDistanceId);
						}
					}
					
					titleRegion.clear();
					
					for(int j = 0; j<innerDistanceIdList.size(); j++) {
						List<Integer> eachMemberProduct = productService.searchByTitle_Region_MemberId(smartSearchDTO.getSmartTitle(), smartSearchDTO.getSmartRegion(), 0, innerDistanceIdList.get(j));
						for(int b = 0; b<eachMemberProduct.size(); b++) {
						
						if(!titleRegion.contains(eachMemberProduct.get(b))) {
						titleRegion.add(eachMemberProduct.get(b));}
						}
					}
				}
		
		ArrayList<Integer> selectedList = new ArrayList<>();
		
		// 날짜로 검색 : 해당 날짜 조건에 부합하지 않는다 => 예약이 null 값인 것과, 예약수락이 없는 리스트까지 포함됨 
		for(int i = 0; i<titleRegion.size(); i++) {

		if(smartSearchDTO.getSmartStartDate() != "" && smartSearchDTO.getSmartEndDate() != "") {
		Integer selected =  productService.searchByRentalDate(smartSearchDTO.getSmartStartDate(), smartSearchDTO.getSmartEndDate(), titleRegion.get(i));
		
		if(selected>0) {
		selectedList.add(selected);  
			}
		}else if(smartSearchDTO.getSmartStartDate() == "" && smartSearchDTO.getSmartEndDate() == "") {
			selectedList.add(titleRegion.get(i));
			}
		} //for 
		
		List<ProductDTO> list = new ArrayList<>();
		
		// 찾은 상품 번호로 상품 list 를 불러옴 
		for(int i = 0; i < selectedList.size(); i++) {
		ProductDTO searchedOne = productService.oneProduct(selectedList.get(i));
		list.add(searchedOne);
		}
		System.out.println(smartSearchDTO.toString());
		
		// 찜 set 
				for (ProductDTO dto : list) {
					int productseq = (int)dto.getId();
					
					int zzim = 0; 
					Object zzimcheck = productService.zzimCount(productseq, sessionid);
					if(zzimcheck!=null) {
						zzim = 1; 
					}
					
					dto.setZzim(zzim);
				} // for 
		
		// 상품 개수 
		int productlength = list.size();
		// 찜목록 리스트   
		List<ProductDTO> zzimProducts = productService.getZzimProducts(sessionid);
		model.addAttribute("orderType", 1);
		model.addAttribute("smartPriceMin", smartSearchDTO.getSmartPriceMin());
		model.addAttribute("smartPriceMax", smartSearchDTO.getSmartPriceMax());
		model.addAttribute("smartTitle", smartSearchDTO.getSmartTitle());
		model.addAttribute("smartRegion", smartSearchDTO.getSmartRegion());
		model.addAttribute("smartStartDate", smartSearchDTO.getSmartStartDate());
		model.addAttribute("smartEndDate", smartSearchDTO.getSmartEndDate());
		
		model.addAttribute("distanceKm", distanceKm);
		
		model.addAttribute("searchType", 4);	
		model.addAttribute("zzimProducts", zzimProducts);	
		model.addAttribute("region", region);
		model.addAttribute("productlength", productlength);
		model.addAttribute("allproduct", list);
		
		return "product/allProduct";
	}
	

	
	
	// 물품 상세페이지 
	@GetMapping("/product/{productid}")
	public String oneProduct(@PathVariable("productid")int productid, Model model, HttpSession session) throws Exception {
		productService.viewCount(productid);
		String sessionid = (String)session.getAttribute("sessionid");
		
		ProductDTO targetProduct = productService.oneProduct(productid);

		Double distance_double = productService.getDistance(sessionid, targetProduct.getUserId());
		int IntDistance = 0;  
		String distance = "";

		if(distance_double==null) {
			distance = "(알수없는 위치)";
		}else if(distance_double!=null) {
			IntDistance = distance_double.intValue();
			if(IntDistance==0) {
				distance = "(1km 이내)";
			}else {
			distance = "(" + IntDistance + "km 거리)";
			}
		}
		
		// 지도 좌표 
		String sessionCoords = productService.getCoords(sessionid);
		
		// 찜 set
		Object zzimcheck = productService.zzimCount(productid, sessionid);
		
		int zzim = 0 ; 
		if(zzimcheck!=null) {
			zzim = 1; 
		}
		
		targetProduct.setZzim(zzim);
		
		// 예약테이블 set
		List<ReservationDTO> reservList = productService.allReservation(productid);
		int reservLength = reservList.size();
		
		model.addAttribute("sessionCoords", sessionCoords);
		model.addAttribute("distance", distance);
		model.addAttribute("reservLength", reservLength);
		model.addAttribute("reservationList", reservList);
		model.addAttribute("oneProduct", targetProduct);
//		System.out.println(targetProduct.getTitle());
		
		return "product/oneProduct";
	}
	
	// 상세페이지 => header랑 연결 알림용  
//		@ResponseBody
//		@GetMapping("/product/{productid}/ajax")
//		public ProductDTO oneProductajax(@PathVariable("productid")int productid, Model model, HttpSession session) throws Exception {
//			
//			String sessionid = (String)session.getAttribute("sessionid");
//			ProductDTO targetProduct = productDAO.oneProduct(productid);
//			model.addAttribute("oneProduct", targetProduct);
//			System.out.println(targetProduct.getTitle());	
//			return targetProduct;
//		}
		
		
		
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
		
		String savePath = "/Users/youngban/upload/";
//		String savePath = "c:/upload/";
		MultipartFile viedoFile = uploaddto.getVideo1();
		
		String originalname1 = viedoFile.getOriginalFilename();
		if(originalname1 != null && !originalname1.isEmpty()) {
		System.out.println("오리지널 :"+originalname1);
		String onlyfilename = originalname1.substring(0, originalname1.indexOf("."));
		String extname = originalname1.substring(originalname1.indexOf("."));
		String newname = onlyfilename + "(" + UUID.randomUUID().toString()+")" + extname;
		File serverfile1 = new File(savePath + newname);
		viedoFile.transferTo(serverfile1);
		
			dto.setVideo(newname);
		}
		
			productService.insertProduct(dto);
		return "redirect:/allproduct/1/1";
	}
	
	// 이미지 미리보기 
	@ResponseBody
	@PostMapping(value ="/ajaxUpload", produces= {"application/json; charset=utf-8"})
	public String uploadajax(MultipartFile imgFile) throws IOException {
		
		String savePath = "/Users/youngban/upload/";
	//	String savePath = "c:/upload/";					

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
		productService.deleteProduct(productid);
		return "redirect:/allproduct/1/1";
	}
	
	
	// 글수정
	@GetMapping("/product/{productid}/update")
	public String updateProduct(@PathVariable("productid")int productid, Model model) {
		model.addAttribute("updateProduct", productService.oneProduct(productid));
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
	
	if(uploaddto.getVideoTitle()!=null && uploaddto.getVideoTitle()!="" && !uploaddto.getVideoTitle().isEmpty()) {
		productDTO.setVideo(uploaddto.getVideoTitle());
	}else {
		
	String savePath = "/Users/youngban/upload/";
//	String savePath = "c:/upload/";
	MultipartFile viedoFile = uploaddto.getVideo1();
	
	String originalname1 = viedoFile.getOriginalFilename();
	if(originalname1 != null && !originalname1.isEmpty()) {
	System.out.println("오리지널 :"+originalname1);
	String onlyfilename = originalname1.substring(0, originalname1.indexOf("."));
	String extname = originalname1.substring(originalname1.indexOf("."));
	String newname = onlyfilename + "(" + UUID.randomUUID().toString()+")" + extname;
	File serverfile1 = new File(savePath + newname);
	viedoFile.transferTo(serverfile1);
	
		productDTO.setVideo(newname);
	}
	}
		
		// update 실행 
		int updateResult = productService.updateProduct(productDTO);
		
		return "redirect:/allproduct/1/1";
	}

	
	// 찜 
		@ResponseBody
		@PostMapping("/product/zzim")
		public String updatezzim(int productseq, String memberid) throws Exception {
			

			int zzimCheck = productService.zzimCheck(productseq, memberid);
			if (zzimCheck == 0) {
				productService.insertZzim(productseq, memberid);
				productService.updateZzim(productseq, memberid);
			} else if (zzimCheck == 1) {
				productService.updateZzimCancel(productseq, memberid);
				productService.deleteZzim(productseq, memberid);
			}
			
			ProductDTO oneProduct = productService.oneProduct(productseq);
			
			
			return "{\"result\" : \"" + zzimCheck + "\", \"title\" : \"" + oneProduct.getTitle() + "\", \"img1\" : \"" + oneProduct.getImg1() + "\", \"id\" : \"" + oneProduct.getId() + "\" }";
		}

	
		
		////				// 거리 AJAX 처리 
//		ArrayList<Integer> innerDistanceIdList = new ArrayList<>();
//		if(distanceKm!=null && (distanceKm.equals("100") || distanceKm.equals("300"))) {
//			int intKm = Integer.parseInt(distanceKm);
//			System.out.println("받아온 거리"+intKm);
//			
//				for(int i=0; i<titleRegion.size(); i++) {
//					Integer innerDistanceId = productDAO.searchByDistance(sessionid, productDAO.oneProduct(titleRegion.get(i)).getUserId(), intKm );
//					if(innerDistanceId>0 && !innerDistanceIdList.contains(innerDistanceId)) {
//					innerDistanceIdList.add(innerDistanceId);
//					}
//				}
//				
//				for(int a = 0; a<innerDistanceIdList.size(); a++) {
//					System.out.println("거리통과한 멤버id : "+innerDistanceIdList.get(a));
//				}
//				
//				titleRegion.clear();
//				
//				for(int j = 0; j<innerDistanceIdList.size(); j++) {
//					List<Integer> eachMemberProduct = productDAO.searchByTitle_Region_MemberId(smartSearchDTO.getSmartTitle(), smartSearchDTO.getSmartRegion(), limit, innerDistanceIdList.get(j));
//					System.out.println("eachmb사이즈 : " + eachMemberProduct.size());
//					
//					for(int b = 0; b<eachMemberProduct.size(); b++) {
//						System.out.println( innerDistanceIdList.get(j)  + "의 상품번호 : "+eachMemberProduct.get(b));
//					
//						if(titleRegion.size()<20) {
//						titleRegion.add(eachMemberProduct.get(b));
//						}
//					}
//				}
//				Collections.sort(titleRegion);
//
//				for(int i = 0; i< titleRegion.size(); i++) {
//					
//					System.out.println(titleRegion.get(i));
//				}
//			}


	//
}
