package kr.or.ddit.users.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.commons.primaryKey.PrimaryKeyIdentify;
import lombok.Data;
import lombok.ToString;

@Data
public class PortfolioFileVO implements PrimaryKeyIdentify {
    private String ptflFileId;
    private String userId;
    private String ptflAfi;
    
    @JsonIgnore
    @ToString.Exclude
    private AtchFileVO atchFile;    
    
    // 로그를 위한 AOP에서 pk 찾기 위한 공통 getter
    @Override
    public String getPrimaryKey() {
        return ptflFileId;
    }
}
