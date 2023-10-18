package com.example.springnew.controller;
import com.example.springnew.forms.ItCompanyForm;
import com.example.springnew.model.ItCompany;
import com.example.springnew.model.UpdatedItCompany;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
@Controller
public class ItCompanyController {
    private static List<ItCompany>employees=new ArrayList<ItCompany>();
    static {
        employees.add(new ItCompany("Josip Vukojevic","Frontend","Middle Developer"));
        employees.add(new ItCompany("Diana Wijk","Testing","QA"));
    }
    @Value("${welcome.message}")
    private String message;

    @Value("${error.message}")
    private String errorMessage;

    @RequestMapping(value = {"/", "/index"}, method = RequestMethod.GET)
    public ModelAndView index(Model model) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("index");
        model.addAttribute("message", message);

        return modelAndView;

    }
    @RequestMapping(value = {"/allemployees"}, method = RequestMethod.GET)
    public ModelAndView personList(Model model) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("employlist");
        model.addAttribute("employees", employees);
        return modelAndView;
    }
    @RequestMapping(value = {"/addemployee"}, method = RequestMethod.GET)
    public  ModelAndView showAddPersonPage(Model model) {
        ModelAndView modelAndView = new ModelAndView("addemployee");
        ItCompanyForm itForm = new ItCompanyForm();
        model.addAttribute("itform", itForm);

        return modelAndView;
    }

    @RequestMapping(value = {"/addemployee"}, method = RequestMethod.POST)
    public ModelAndView savePerson(Model model, @ModelAttribute("itform") ItCompanyForm itForm) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("employlist");
        String name = itForm.getName();
        String department = itForm.getDepartment();
        String role=itForm.getRole();

        if (name != null && name.length() > 0 && department != null && department.length() > 0 && role != null && role.length() > 0) {
            ItCompany newEmp = new ItCompany(name, department,role);
            employees.add(newEmp);
            model.addAttribute("employees",employees);
            return modelAndView;
        }
        model.addAttribute("errorMessage", errorMessage);
        modelAndView.setViewName("addemployee");
        return modelAndView;
    }
    @RequestMapping(value = {"/deleteemployee"}, method = RequestMethod.GET)
    public ModelAndView showDeleteEmp(Model model)
    {
        ModelAndView modelAndView = new ModelAndView("deleteemployee");
        var employForm = new ItCompanyForm();
        model.addAttribute("employform", employForm);
        return modelAndView;
    }


    @RequestMapping(value = {"/deleteemployee"}, method = RequestMethod.POST)
    public ModelAndView deleteEmp(Model model, @ModelAttribute("employform") ItCompanyForm empForm)
    {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("employlist");
        String name = empForm.getName();
        String department = empForm.getDepartment();
        String role = empForm.getRole();
        if (name != null && name.length() > 0 && department != null && department.length() > 0 && role != null && role.length() > 0)
        {
            var newEmployee = new ItCompany(name,department,role);
            if (employees.contains(newEmployee))
            {
                employees.remove(newEmployee);
                model.addAttribute("employees", employees);
                return modelAndView;
            }
        }
        model.addAttribute("errorMessage", errorMessage);
        modelAndView.setViewName("deleteemployee");
        return modelAndView;
    }


    @RequestMapping(value = {"/updateemployee"},method=RequestMethod.GET)
    public ModelAndView showUpdateEmp(Model model)
    {
        ModelAndView modelAndView = new ModelAndView("updateemployee");
        var albumForm = new UpdatedItCompany();
        model.addAttribute("employeeform", albumForm);
        return modelAndView;
    }


    @RequestMapping(value = {"/updateemployee"},method=RequestMethod.POST)
    public ModelAndView updateEmp(Model model, @ModelAttribute("employeeform") UpdatedItCompany updateEmp)
    {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("employlist");
        String oldName = updateEmp.getOldName();
        String oldDepartment = updateEmp.getOldDepartment();
        String oldRole = updateEmp.getOldRole();
        var newName = updateEmp.getNewName();
        var newDepartment = updateEmp.getNewDepartment();
        var newRole = updateEmp.getNewRole();
        if (oldName != null && oldName.length() > 0 && oldDepartment != null && oldDepartment.length() > 0 &&
                oldRole != null && oldRole.length() > 0 && newName != null && newName.length() > 0
                 && newDepartment!=null&&newDepartment.length() > 0&&newRole!=null&&newRole.length() > 0)
        {
            var newEmp = new ItCompany(newName, newDepartment, newRole);
            var oldEmp = new ItCompany(oldName, oldDepartment,oldRole);
            if (employees.contains(oldEmp))
            {
                for (var empSearch: employees)
                {
                    if (empSearch.getName().equals(oldName) && empSearch.getDepartment().equals(oldDepartment)&&empSearch.getRole().equals(oldRole))
                    {
                        empSearch.setName(newName);
                        empSearch.setDepartment(newDepartment);
                        empSearch.setRole(newRole);
                    }
                }
                model.addAttribute("employees", employees);
                return modelAndView;
            }
        }
        model.addAttribute("errorMessage", errorMessage);
        modelAndView.setViewName("updateemployee");
        return modelAndView;
    }
}
