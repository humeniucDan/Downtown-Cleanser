package com.example.be_bitstone.service;

import com.example.be_bitstone.entity.Image;
import com.example.be_bitstone.repository.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ImageService {
    @Autowired
    private ImageRepository imageRepository;

    public Image save(Image image){
        return imageRepository.save(image);
    }

    public List<Image> findAllWithDetectionsClassIds(List<Long> classIds){
        return imageRepository.findAllWithDetectionsClassIds(classIds);
    }

    public Optional<Image> findById(Long imageId) {
        return imageRepository.findById(imageId);
    }
}
