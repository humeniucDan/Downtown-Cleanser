package com.example.be_bitstone.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;
import jakarta.persistence.Id;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name="users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "email", nullable = false, unique = true)
    private String email;
    @Column(name = "full_name")
    private String fullName;
    @Column(name = "password", nullable = false)
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;
    @Column(name = "is_admin")
    private Boolean isAdmin = false;
    @Column(name = "is_rep")
    private Boolean isRep = false;
    @Column(name = "rep_authority_id")
    private Long repAuthorityId;
    @Column(name = "score")
    private Integer score = 0;
    @OneToMany
    @JoinColumn(name = "posted_by")
    private List<Image> images;
}

