package com.kh.urbantable.food.model.vo;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Food {
   private String foodNo;
   private String foodName;
   private String foodSectionNo;
   private String foodCompany;
   private int foodMarketPrice;
   private int foodMemberPrice;
   private int foodEnabled;
   private String foodImg;
}