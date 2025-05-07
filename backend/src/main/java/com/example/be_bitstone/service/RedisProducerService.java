package com.example.be_bitstone.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

@Service
public class RedisProducerService {
    private static final Logger logger = LoggerFactory.getLogger(RedisProducerService.class);

    @Autowired
    private StringRedisTemplate template;
    private static final String QUEUE   = "queue";

    public boolean enqueue(String text) {
        try {
            template.opsForList().leftPush(QUEUE, text);
            logger.info("Pushed : " + text);
            return true;
        }
        catch (Exception e) {
            logger.error("Error pushing :" + text);
            return false;
        }
    }
}
