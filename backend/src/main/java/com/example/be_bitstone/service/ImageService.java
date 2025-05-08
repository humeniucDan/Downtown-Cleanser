package com.example.be_bitstone.service;

import com.example.be_bitstone.entity.Image;
import com.example.be_bitstone.repository.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ImageService {
    @Autowired
    private ImageRepository imageRepository;

    public Image save(Image image){
        return imageRepository.save(image);
    }
}
