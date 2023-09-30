package com.maximus.amp.service.impl;

import static org.junit.Assert.assertTrue;
import static org.mockito.BDDMockito.given;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import com.maximus.amp.Constants;
import com.maximus.amp.dao.LookupDao;
import com.maximus.amp.model.LabelValue;
import com.maximus.amp.model.Role;


public class LookupManagerImplTest extends BaseManagerMockTestCase {

    @Mock
    private LookupDao lookupDao;

    @InjectMocks
    private LookupManagerImpl mgr = new LookupManagerImpl();


    @Test
    public void testGetAllRoles() {
        log.debug("entered 'testGetAllRoles' method");

        //given
        Role role = new Role(Constants.ADMIN_ROLE);
        final List<Role> testData = new ArrayList<Role>();
        testData.add(role);

        given(lookupDao.getRoles("APPLICATION")).willReturn(testData);

        //when
        List<LabelValue> roles = mgr.getApplicationRoles();

        //then
        assertTrue(roles.size() > 0);
    }
    


}
