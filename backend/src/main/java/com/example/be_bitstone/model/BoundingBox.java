package com.example.be_bitstone.model;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoundingBox {
    int x1, y1, x2, y2, classId;
}
