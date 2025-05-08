package com.example.be_bitstone.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

@Service
public class RedisProducerService {

    @Autowired
    private StringRedisTemplate template;
    private static final String QUEUE   = "queue";

    public boolean enqueue(String text) {
        try {
            template.opsForList().leftPush(QUEUE, text);
            return true;
        }
        catch (Exception e) {
            return false;
        }
    }
}