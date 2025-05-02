package com.example.be_accesa.Service;

import com.example.be_accesa.Config.RedisConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.stereotype.Service;

@Service
public class RedisMessageReceiver implements MessageListener {
    private static final Logger logger = LoggerFactory.getLogger(RedisMessageReceiver.class);
    private static final String ACK_QUEUE = "queue:ack";
    private final FilebaseService filebaseService;
    public RedisMessageReceiver(FilebaseService filebaseService) {
        this.filebaseService = filebaseService;
    }

    @Override
    public void onMessage(Message message, byte[] pattern) {
        String channel = new String(pattern);
        String messageReceived = message.toString();

        logger.info("Redis received " + messageReceived + " in channel " + channel);

        String[] splitMessage = messageReceived.split(":");

        if(channel.equals(ACK_QUEUE)) {
            logger.info("Processing CV ACK " + messageReceived);

            if(splitMessage[0].equals("e")) {
                String cvFilename = "/" + splitMessage[1];
                filebaseService.deleteFile(cvFilename);
            }
        }
    }
}
