package com.maximus.amp.webapp.util;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.convert.converter.Converter;

import com.maximus.amp.dao.GenericDao;
import com.maximus.amp.model.Division;


public class DivisionConverter implements Converter<String, Division> {
	
	@Autowired
	@Qualifier("divisionDao")
	private GenericDao<Division, Long> dao = null;

	@Override
	@Transactional
	public Division convert(String source) {
		// TODO Auto-generated method stub
		Division division = dao.get(Long.parseLong(source));
		return division;
	}


	
	
	
}
