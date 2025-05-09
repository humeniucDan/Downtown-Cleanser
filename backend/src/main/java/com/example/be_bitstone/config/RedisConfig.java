// src/main/java/com/example/be_bitstone/config/RedisConfig.java
package com.example.be_bitstone.config;

import com.example.be_bitstone.service.FilebaseService;
import com.example.be_bitstone.service.RedisConsumerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.listener.PatternTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;

/**
 * Redis configuration: sets up a listener container that delegates messages
 * on the 'queue:ack' topic to RedisConsumerService.onMessage.
 */
@Configuration
public class RedisConfig {
    private static final String ACK_QUEUE = "queue:ack";

    @Autowired
    private FilebaseService filebaseService;

    /**
     * Configure the listener container, wiring the listener adapter and topic.
     */
    @Bean
    public RedisMessageListenerContainer container(RedisConnectionFactory connectionFactory,
                                                   MessageListenerAdapter listenerAdapter) {
        RedisMessageListenerContainer container = new RedisMessageListenerContainer();
        container.setConnectionFactory(connectionFactory);
        // Subscribe to the ACK_QUEUE topic
        container.addMessageListener(listenerAdapter, new PatternTopic(ACK_QUEUE));
        return container;
    }

    /**
     * Create a listener adapter that delegates to the RedisConsumerService bean's onMessage method.
     * Important: inject the existing bean rather than creating a new instance.
     */
    @Bean
    public MessageListenerAdapter listenerAdapter(RedisConsumerService consumerService) {
        // 'onMessage' is the method name in RedisConsumerService
        return new MessageListenerAdapter(consumerService, "onMessage");
    }

    /**
     * Template for publishing and reading string messages.
     */
    @Bean
    public StringRedisTemplate template(RedisConnectionFactory connectionFactory) {
        return new StringRedisTemplate(connectionFactory);
    }
}