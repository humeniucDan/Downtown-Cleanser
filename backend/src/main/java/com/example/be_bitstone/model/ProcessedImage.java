package com.example.be_bitstone.model;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ProcessedImage {
    String originalImageUrl;
    String editedImageUrl;
    List<BoundingBox> boundingBoxList;
}
