package com.kh.urbantable.recipe.model.vo;

import java.sql.Date;

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
public class BoardComment {

	private String boardCommentNo;
	private String recipeNo;
	private String boardCommentWriter;
	private int boardCommentLevel;
	private String boardCommentContent;
	private String boardCommentRef;
	private Date boardCommentDate;
	private int boardCommentEnabled;
}
