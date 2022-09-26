package connectus.chat;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.RestController;

/*
 * @RestController public class ChattingController { private final
 * ChattingService chattingService; private final SimpMessagingTemplate
 * simpMessagingTemplate;
 * 
 * public ChattingController(ChattingService chattingService,
 * SimpMessagingTemplate simpMessagingTemplate) { this.chattingService =
 * chattingService; this.simpMessagingTemplate = simpMessagingTemplate; }
 * 
 * @MessageMapping("/messages") public void chat(ChatRequest chatRequest) {
 * chattingService.save(chatRequest);
 * simpMessagingTemplate.convertAndSend("/subscribe/rooms/" +
 * chatRequest.getRoomId(), chatRequest.getMessage()); } }
 */