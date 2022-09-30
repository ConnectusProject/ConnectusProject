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
 
    //채팅으로 거래하기(productInfo 화면)
    @RequestMapping(value="/chatMessage", method=RequestMethod.GET)
    public String getWebSocketWithSockJs(ChatRoom chatRoom, Model model, HttpSession session ) throws IOException {
        //productInfo화면에서 Chat화면에 전달해줄 parameter
        
//        String buyerId = (String) session.getAttribute("sessionid");
//        chatRoom.setBuyerId(buyerId);
    	
   
        
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
    
    
    
    
    @RequestMapping(value="/chatList", method=RequestMethod.GET)
	public String getChatList(Model model, HttpSession session) {

		 return "chat/chatList";
	}
    
    
    
    
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
			 ja.put(jo);
		}
		 JSONObject jsnResult = new JSONObject();
		 jsnResult.put("chatList", ja);
		 String result = jsnResult.toString();
		 System.out.println("chatResult toString: " + result);
		
		 return result;
	}

    
    
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
    
    
    
    
    
    
    
    @MessageMapping("/broadcast")
    public void send(ChatRoom chatRoom) throws IOException {
 
    	System.out.println("메세지 맵핑 : " + chatRoom.toString()); 
        chatRoom.setSendTime(TimeUtils.getCurrentTimeStamp());
        //append message to txtFile
        chatRoomService.appendMessage(chatRoom);
        
        int id = chatRoom.getId();
        String url = "/user/" + id + "/queue/messages";
        simpMessage.convertAndSend(url, new ChatRoom(chatRoom.getContent(), chatRoom.getSenderId(), chatRoom.getSendTime())); 
    }
    
    
    
}
