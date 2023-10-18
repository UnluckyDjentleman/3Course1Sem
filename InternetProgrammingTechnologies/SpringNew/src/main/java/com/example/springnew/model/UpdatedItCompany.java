package com.example.springnew.model;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdatedItCompany {
    private String oldName;
    private String oldDepartment;
    private String oldRole;
    private String newName;
    private String newDepartment;
    private String newRole;
}
