package com.example.be_bitstone.handlers;

import com.example.be_bitstone.service.FilebaseService;
import com.example.be_bitstone.service.RedisProducerService;
import com.example.be_bitstone.utils.FileHasher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ImageHandler {
    @Autowired
    private FilebaseService filebaseService;
    @Autowired
    private RedisProducerService redisProducerService;

    public Boolean uploadImageForProcessing(MultipartFile image){
        String fileHash = FileHasher.hashMultipartFile(image) + ".png";
        try{
            System.out.println(filebaseService.uploadFile(image, fileHash));
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
        if(!redisProducerService.enqueue(fileHash)){
            System.out.println("Enqueueing file name failed!");
            return false;
        }
        return true;
    }
}
