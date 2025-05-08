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
    private static final Logger logger = LoggerFactory.getLogger(RedisConsumerService.class);
    private static final String ACK_QUEUE = "queue:ack";

    private final FilebaseService filebaseService;

    public RedisConsumerService(FilebaseService filebaseService) {
        this.filebaseService = filebaseService;
    }

    /**
     * Called when a message arrives. Use message.getChannel() to retrieve the actual channel.
     */
    @Override
    public void onMessage(Message message, byte[] pattern) {
        String channel = new String(message.getChannel());
        String messageBody = new String(message.getBody());

        if (ACK_QUEUE.equals(channel)) {
            logger.info("Processing ACK on {}: {}", channel, messageBody);
            // TODO: delegate to filebaseService as needed
        } else {
            logger.warn("Received message on unexpected channel {}: {}", channel, messageBody);
        }
    }
}