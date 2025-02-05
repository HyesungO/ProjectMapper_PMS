package kr.or.ddit.atch.vo;

import java.time.LocalDate;
import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.springframework.lang.Nullable;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.ToString;

@Data
public class AtchFileVO {
	private Integer atchFileId;
	private LocalDate atchCreateDt;
	private boolean atchUseAt;

	@Nullable
	@Valid
	private List<@NotNull AtchFileDetailVO> fileDetails;
	// Has Many 관계 : 부모가 자식을 여러개
}
