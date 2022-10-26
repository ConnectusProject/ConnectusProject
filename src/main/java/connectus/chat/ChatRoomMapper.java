package connectus.chat;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import connectus.chat.ChatList;
import connectus.chat.ChatRoom;

@Mapper
@Repository
public interface ChatRoomMapper {
		
	public void addChatRoom (ChatRoom chatRoom) throws IOException;
	
	//String chatId, String pr_id, String senderId, String recipientId
	
	public List<ChatList> findByUserId(String userId);
	
	public int countByChatId(int pr_id, String buyerId);
	
	public ChatRoom findByChatId(int pr_id, String buyerId);

	public void appendMessage(ChatRoom chatRoom) throws FileNotFoundException, IOException;

	public int getId(int pr_id, String buyerId);

	public void updateFileName(int id, String fileName);
	
	public void updateChatReadBuy(int id, int chatReadBuy);
	
	public void updateChatReadSell(int id, int chatReadSell);

	public int getUnreadMessages(String userId);
	
	public List<Integer> getUnreadChatRoom(String userId);
	
	
}