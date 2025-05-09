package com.example.be_bitstone.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.stereotype.Service;

/**
 * Consumes messages from Redis channels.
 */
@Service
public class RedisConsumerService implements MessageListener {
    private static final String ACK_QUEUE = "queue:ack";

    private final FilebaseService filebaseService;

    public RedisConsumerService(FilebaseService filebaseService) {
        this.filebaseService = filebaseService;
    }
    @Override
    public void onMessage(Message message, byte[] pattern) {
        String channel = new String(message.getChannel());
        String messageBody = new String(message.getBody());

        if (ACK_QUEUE.equals(channel)) {
            // TODO: delegate to filebaseService as needed
            System.out.println("Received message on expected channel " +  channel + ":" + messageBody);
        } else {
            System.out.println("Received message on unexpected channel " +  channel + ":" + messageBody);
        }
    }
}