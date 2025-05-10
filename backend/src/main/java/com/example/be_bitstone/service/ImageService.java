package com.example.be_bitstone.service;

import com.example.be_bitstone.entity.Image;
import com.example.be_bitstone.repository.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ImageService {
    @Autowired
    private ImageRepository imageRepository;

    public Image save(Image image){
        return imageRepository.save(image);
    }
    public List<Image> findAllWithDetectionsClassId(Integer classId){return imageRepository.findAllWithDetectionsClassId(classId);}
}
