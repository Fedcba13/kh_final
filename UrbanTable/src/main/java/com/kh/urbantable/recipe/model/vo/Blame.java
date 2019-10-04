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
public class Blame {

	private String blameId;
	private String memberId;
	private String blameContent;
	private String blameTargetId;
	private int targetType;
	private Date blameDate;
	private int blameAction;
}
