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
import connectus.reservation.ReservationDTO;


@Controller
public class ProductController {

	
	@Autowired
	ProductDAO productDAO;
	
	
	// 홈 
	@GetMapping("/")
	public String home() {
		return "home";
	}

	// 전체 물품 조회
	@GetMapping("/allproduct")
	public String allProduct(Model model, HttpSession session) throws Exception {
		String sessionid = (String)session.getAttribute("sessionid");
		
		List<ProductDTO> list = productDAO.allBoard();
		
		
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
		
		int boardlength = list.size();
		
	
		model.addAttribute("boardlength", boardlength);
		model.addAttribute("allboard", list);
		return "product/allProduct";
	}
	
	// 물품 상세페이지 
	@GetMapping("/product/{productid}")
	public String oneProduct(@PathVariable("productid")int boardid, Model model, HttpSession session) throws Exception {
		
		String sessionid = (String)session.getAttribute("sessionid");
		
		
		ProductDTO targetBoard = productDAO.oneBoard(boardid);
		
		
		Object zzimcheck = productDAO.zzimCount(boardid, sessionid);
		
		int zzim = 0 ; 
		if(zzimcheck!=null) {
			zzim = 1; 
		}
		
		targetBoard.setZzim(zzim);
		
		List<ReservationDTO> reservList = productDAO.allReservation(boardid);
		
		
		model.addAttribute("reservationList", reservList);
		model.addAttribute("oneBoard", targetBoard);

		return "product/oneProduct";
	}
	
	
	
	//글작성 폼 
	@GetMapping("/registerProduct")
	public String registerProduct() {
		
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
			ApiClient apiClient = new ApiClient(geoapiignore.geoaccess, geoapiignore.geosecret);
			
			String geo = apiClient.run(geoapiignore.geoip);
			
			int index = geo.indexOf("r3");
			int index2 = geo.indexOf("lat");
			
			String region = geo.substring(index+6, index2-3);
			System.out.println(region);
			
			dto.setBoardRegion(region); 
			
			productDAO.insertBoard(dto);
		return "redirect:/allproduct";
	}
	
	// 이미지 미리보기 
	@ResponseBody
	@PostMapping(value ="/ajaxUpload", produces= {"application/json; charset=utf-8"})
	public String uploadajax(MultipartFile imgFile) throws IOException {
		
		String savePath = "c:/upload/";

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
	public String deleteProduct(@PathVariable("productid")int boardid) {
		productDAO.deleteBoard(boardid);
		return "redirect:/allproduct";
	}
	
	
	// 글수정
	@GetMapping("/product/{productid}/update")
	public String updateProduct(@PathVariable("productid")int boardid, Model model) {
		model.addAttribute("updateBoard", productDAO.oneBoard(boardid));
		return "product/updateProductForm";
	}

	@PostMapping("/product/{productid}/updateprocess")
	public String updateProductProcess(@PathVariable("productid")int boardid,ProductDTO boardDTO, UploadDTO uploaddto) throws IllegalStateException, IOException {
		// update 할 아이디 set 
		boardDTO.setId(boardid);
		
		// 이미지 다시 Set 
	if(uploaddto.getFile1()!=null) {
		boardDTO.setImg1(uploaddto.getFile1());
	}
	if(uploaddto.getFile2()!=null) {
		boardDTO.setImg2(uploaddto.getFile2());
	}
	if(uploaddto.getFile3()!=null) {
		boardDTO.setImg3(uploaddto.getFile3());
	}
	if(uploaddto.getFile4()!=null) {
		boardDTO.setImg4(uploaddto.getFile4());
	}
	if(uploaddto.getFile5()!=null) {
		boardDTO.setImg5(uploaddto.getFile5());
	}
	if(uploaddto.getFile6()!=null) {
		boardDTO.setImg6(uploaddto.getFile6());
	}
	
		
		// update 실행 
		int updateResult = productDAO.updateBoard(boardDTO);
		
		return "redirect:/allproduct";
	}

	
	
	// 검색
	@GetMapping("/searchproduct")
	public String searchList(String item, String search, Model model) {

		HashMap<String, String> map = new HashMap<>();
		map.put("item", item);
		map.put("search", search);

		List<ProductDTO> searchList = productDAO.searchList(map);
		
		model.addAttribute("searchList", searchList);
		return "product/searchList";
	}
	
	
	// 찜 
		@ResponseBody
		@PostMapping("/product/zzim")
		public String updatezzim(int productseq, String memberid) throws Exception {
			

			int zzim = 0; 
			int zzimCheck = productDAO.zzimCheck(productseq, memberid);
			if (zzimCheck == 0) {
				productDAO.insertZzim(productseq, memberid);
				productDAO.updateZzim(productseq, memberid);
				zzim = 1;
			} else if (zzimCheck == 1) {
				productDAO.updateZzimCancel(productseq, memberid);
				productDAO.deleteZzim(productseq, memberid);
			}
			

			return "{\"result\" : \"" + zzimCheck + "\", \"result2\" : \"" + zzim + "\" }";
		}

	
	
		
		
		
	
	
	
	

	//
}
