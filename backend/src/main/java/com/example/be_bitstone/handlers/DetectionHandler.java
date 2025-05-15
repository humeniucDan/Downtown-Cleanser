package com.example.be_bitstone.handlers;

import com.example.be_bitstone.dto.UserTokenDto;
import com.example.be_bitstone.entity.Authority;
import com.example.be_bitstone.entity.Detection;
import com.example.be_bitstone.entity.Image;
import com.example.be_bitstone.entity.User;
import com.example.be_bitstone.repository.AuthorityRepository;
import com.example.be_bitstone.service.DetectionService;
import com.example.be_bitstone.service.ImageService;
import com.example.be_bitstone.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class DetectionHandler {
    @Autowired
    private DetectionService detectionService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private UserService userService;
    @Autowired
    private AuthorityRepository authorityRepository;

    public ResponseEntity<?> markDetectionResolved(UserTokenDto userTokenData, Long id) {
        /// TODO: check if the user has the qualifications tp resolve such an issue
        /// basically check if it's a rep and if the rep'ing authority has the detection classId as one of their resolvableDetectionClassIds
        /// if not return a 403 unauthorized

        System.out.printf("userTokenData: %s\n", userTokenData);
        if(userTokenData.getIsRep() == null || userTokenData.getIsRep() == false){
            return new ResponseEntity<>("Only reps can mark issues as resolved!", HttpStatus.UNAUTHORIZED);
        }
        Optional<Authority> optAuthority = authorityRepository.findById(userTokenData.getRepAuthorityId());
        if(optAuthority.isEmpty()){
            return new ResponseEntity<>("No such authority!", HttpStatus.BAD_REQUEST);
        }
        Authority authority = optAuthority.get();

        Optional<Detection> optDetection = detectionService.findById(id);
        if(optDetection.isEmpty()){
            return new ResponseEntity<>("No such detection!", HttpStatus.BAD_REQUEST);
        }
        Detection detection = optDetection.get();
        /// check if the authority is allowed to resolve such detections;
        if(!authority.getAccessibleProblemClassIds().contains(detection.getDetectionClass().getId())){ // if the detection.classId is among the auth.AccessibleProblemClassIds
            return new ResponseEntity<>("Unqualified to resolve such an issue!", HttpStatus.UNAUTHORIZED);
        }

        optDetection = detectionService.markDetectionResolved(id);
        if(optDetection.isEmpty()){
            return new ResponseEntity<>("No such detection!", HttpStatus.BAD_REQUEST);
        }
        detection = optDetection.get();

        Optional<Image> optImage = imageService.findById(detection.getImageId());
        /// TODO: we may add a field to images that contains the number of total detections and a field with resolved detection
        ///   we could update it here and when they are equal we could also mark the whole image as resolved
        if(optImage.isEmpty()){
            return new ResponseEntity<>("No image attached to detection!", HttpStatus.BAD_REQUEST);
        }
        Optional<User> optUser = userService.findById(optImage.get().getPostedBy());
        if(optUser.isEmpty()){
            return new ResponseEntity<>("No user attached to image!", HttpStatus.BAD_REQUEST);
        }
        User user = optUser.get();
        user.setScore(
                user.getScore() + 1
        );
        userService.save(user);

        return new ResponseEntity<>(detection, HttpStatus.OK);
    }
}
