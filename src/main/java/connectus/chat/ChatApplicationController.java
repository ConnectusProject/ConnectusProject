package connectus.chat;

import java.io.IOException;
import java.util.List;
import java.util.Map;
 
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import connectus.chat.ChatRoomService;
import connectus.chat.ChatList;
import connectus.chat.ChatRoom;
import connectus.chat.TimeUtils;
 
@Controller
public class ChatApplicationController {
    
 
    @Autowired
    private SimpMessagingTemplate simpMessage;
    
    @Autowired
    private ChatRoomService chatRoomService;
 
    //상세페이지에서 채팅방 입장
    @RequestMapping(value="/chatMessage", method=RequestMethod.GET)
    public String getWebSocketWithSockJs(ChatRoom chatRoom, Model model, HttpSession session ) throws IOException {
        //productInfo화면에서 Chat화면에 전달해줄 parameter
        
//        String buyerId = (String) session.getAttribute("sessionid");
//        chatRoom.setBuyerId(buyerId); < 이거 체크 필요
    	
   
        
        //이미 chatRoom이 만들어져있는지 확인
        if (chatRoomService.countByChatId(chatRoom.getPr_id(), chatRoom.getBuyerId()) > 0) {
        	System.out.println("채팅방 존재");
            //get ChatRoomInfo
            ChatRoom chatRoomTemp = chatRoomService.findByChatId(chatRoom.getPr_id(), chatRoom.getBuyerId());
            //load existing chat history
            List<ChatRoom> chatHistory = chatRoomService.readChatHistory(chatRoomTemp);
            //transfer chatHistory Model to View
            model.addAttribute("chatHistory", chatHistory);
            
        } else {
            //chatRoom 생성            
            chatRoomService.addChatRoom(chatRoom);            
            //text file 생성
            chatRoomService.createFile(chatRoom.getPr_id(), chatRoomService.getId(chatRoom.getPr_id(), chatRoom.getBuyerId()));                                
        }
 
            //chatRoom Add 시 생성될 chatId
            chatRoom.setId(chatRoomService.getId(chatRoom.getPr_id(), chatRoom.getBuyerId()));
            
            System.out.println("모델 : "+chatRoom.toString());

            //chatRoom 객체 Model에 저장해 view로 전달
            model.addAttribute("chatRoomInfo", chatRoom);
        
        return "chat/chatBroadcastChatRoom";
    }
    
        

    // 채팅리스트에서 채팅방 입장
    @RequestMapping(value="/chatRoom/{pr_id}/{buyerId}", method=RequestMethod.GET)
	public String getChatRoom(@PathVariable Map<String, String> requestVar,
			Model model) throws IOException {
		
		String buyerId = requestVar.get("buyerId");
		int pr_id = Integer.parseInt(requestVar.get("pr_id"));
			
		//read chatHistory
		ChatRoom chatRoomRead = chatRoomService.findByChatId(pr_id, buyerId);
		List<ChatRoom> chatHistory = chatRoomService.readChatHistory(chatRoomRead);
		model.addAttribute("chatHistory", chatHistory);
		
		int id = chatRoomService.getId(pr_id, buyerId);
		String pr_title = chatRoomRead.getPr_title();
		String sellerId = chatRoomRead.getSellerId();
		
		model.addAttribute("id", id);
		model.addAttribute("pr_id", pr_id);
		model.addAttribute("buyerId", buyerId);
		model.addAttribute("sellerId", sellerId);
		model.addAttribute("pr_title", pr_title);
		
		return "chat/chatBroadcastChatRoomList";
	}
    
    
    
    // 채팅방 리스트 
    @RequestMapping(value="/chatList", method=RequestMethod.GET)
   	public String getChatList(Model model, HttpSession session) {

   		 return "chat/chatList";
   	}
       
       
    // 채팅방 리스트 AJAX    
    @RequestMapping(value="/chatList/ajax", method=RequestMethod.POST)
   	@ResponseBody
   	public String chatList(@RequestBody String json) {
   		
   		JSONObject jsn = new JSONObject(json);
   		String sessionid = (String) jsn.get("sessionid");
   		List<ChatList> chatRoomList = chatRoomService.findByUserId(sessionid);
   		
   		System.out.println(chatRoomList.get(0).toString());
   		System.out.println(chatRoomList.get(1).toString());
   		
   		
   		
   		JSONArray ja = new JSONArray();

   		 for (ChatList chatList : chatRoomList) {
   			
   			 JSONObject jo = new JSONObject();
   			 jo.put("pr_id", chatList.getPr_id());
   			 jo.put("buyerId", chatList.getBuyerId());
   			 jo.put("pr_title", chatList.getPr_title());
   			 jo.put("img1", chatList.getImg1());
   			 jo.put("sellerId", chatList.getSellerId());
   			 ja.put(jo);
   		}
   		 JSONObject jsnResult = new JSONObject();
   		 jsnResult.put("chatList", ja);
   		 String result = jsnResult.toString();
   		 System.out.println("chatResult toString: " + result);
   		
   		 return result;
   	}
    
    
    
    
    @MessageMapping("/broadcast")
    public void send(ChatRoom chatRoom) throws IOException {
 
    	System.out.println("메세지 맵핑 : " + chatRoom.toString()); 
        chatRoom.setSendTime(TimeUtils.getCurrentTimeStamp());
        //append message to txtFile
        chatRoomService.appendMessage(chatRoom);
        
        int id = chatRoom.getId();
        String url = "/user/" + id + "/queue/messages";
        simpMessage.convertAndSend(url, new ChatRoom(chatRoom.getContent(), chatRoom.getSenderId(), chatRoom.getSendTime())); 
        
        
        if(chatRoom.getSenderId().equals(chatRoom.getBuyerId())){
        chatRoomService.updateChatReadBuy(id, 1);}
        else if(chatRoom.getSenderId().equals(chatRoom.getSellerId())) {
        	chatRoomService.updateChatReadSell(id, 1);}
    }
    
    
    
    // 알림
    //채팅리스트로 들어갔을 때 읽음처리 
    @RequestMapping("/chatread/chatroom/ajax")
	public void ajaxChatRoomRead(@RequestBody String json) throws IOException {
		JSONObject jsn = new JSONObject(json);
		String idStr = (String) jsn.get("id");
		int id = Integer.parseInt(idStr);
		String flag = (String) jsn.get("flag");
		
		System.out.println(flag);
		if (flag.equals("sell")) {
			chatRoomService.updateChatReadSell(id, 1);
		} else {
			chatRoomService.updateChatReadBuy(id, 1);
		}
		
	}
    
    
    
    //상세페이지로 들어갔을 때 읽음처리
	@RequestMapping(value="/chatread/product/ajax", method=RequestMethod.POST)
	public void ajaxChatProductRead(@RequestBody String json) throws IOException {
		JSONObject jsn = new JSONObject(json);
		String idStr = (String) jsn.get("id");
		int id = Integer.parseInt(idStr);
		chatRoomService.updateChatReadBuy(id, 1);
	}
    
    
	// Header 에 채팅 알림숫자 표시 
	@RequestMapping(value="/chatUnreadAlert/ajax", method=RequestMethod.POST)
	@ResponseBody
	public int chatUnread(@RequestBody String json) {
		
		JSONObject jsn = new JSONObject(json);
		String sessionId = (String) jsn.get("sessionId");
    	int messages = chatRoomService.getUnreadMessages(sessionId);
		return messages;
	}

	// 
	@RequestMapping(value="/chatUnreadMessageInfo/ajax", method=RequestMethod.POST)
	@ResponseBody
	public String chatListUnread(@RequestBody String json) {
		//ajax가 전송한 String을 key, value로 분류하기 위해 JSON Object convert
		JSONObject jsn = new JSONObject(json);
		//JSON.get([mapped name])으로 value 추출하기
		String sessionid = (String) jsn.get("sessionid");
		//email에 해당되는 모든 chatRoom select 받기
		List<ChatList> chatRoomList = chatRoomService.findByUserId(sessionid);
		//chatRoom 정보는 JSON Array에 저장됨
		JSONArray ja = new JSONArray();
		//email에 해당되는 읽지 않은 chatRoom select 받기
		List<Integer> unreadChatId = chatRoomService.getUnreadChatRoom(sessionid);

		 for (ChatList chatList : chatRoomList) {
			//chatRoom 정보를 JSON Object에 put 해줌, chatRoom이 반복문에서 넘어갈 때마다 객체 초기화 
			 JSONObject jo = new JSONObject();
			 jo.put("pr_id", chatList.getPr_id());
			 jo.put("buyerId", chatList.getBuyerId());
			 jo.put("pr_img_1", chatList.getImg1());
		 	//리스트에 출력할 상대방 닉네임 확인
		 if (chatList.getBuyerId().equals(sessionid)) {
			 jo.put("senderName", chatList.getSellerId());
		 } else {
			 jo.put("senderName", chatList.getBuyerId());
		 }
		 
		 	 jo.put("pr_title", chatList.getPr_title());
		 //읽지 않은 chatRoom이 0개일때
		 if (unreadChatId.size() == 0) {
			 jo.put("messageUnread", "");
		 	} else {
		 		//읽지 않은 chatRoomId들과 현재 chatRoomId 대조 후 처리 
				 for (int ele : unreadChatId) {
					 	if (chatList.getId() == ele) {
					 		jo.put("messageUnread", "새 메세지");
					 		break;
					 	} else {
					 		jo.put("messageUnread", "");
					 	}
				 }
			}
		 	ja.put(jo);
		}
		 //Javascript에 parsing 할 수 있도록 JSON Object에 Array를 담아줌
		 JSONObject jsnResult = new JSONObject();
		 jsnResult.put("chatList", ja);
		 //String으로 변환해주면 끝, 프런트<->백엔드 전달은 String으로 이루어지며 형식은 JSON을 선택했음 
		 String result = jsnResult.toString();
		 //View로 result를 return해줌
		 return result;
	}
    
    
    
    
}
