package com.maximus.amp.webapp.listener;

import java.io.Serializable;

import org.hibernate.type.Type;

/**
 * Entity property change listener
 *
 * @author Nimo Naamani
 *
 * @param <T> - the class this listener listens on
 */
public interface PropertyChangeListener<T> {
 
  /**
   * Used to do something on change. Note that the type of values is inferred by <E>
   * 
   * @param propertyName - the property name on the entity
   * @param entity - the entity object
   * @param oldVal - the old value
   * @param newVal - the new value
   */
  <E> void onFlushDirty(Object entity, E oldVal, E newVal, String propertyName);
  
  /**
   * Used to do something on save. Note that the type of values is inferred by <E>
   * 
   * @param propertyName - the property name on the entity
   * @param entity - the entity object
   * @param oldVal - the old value
   * @param newVal - the new value
   */
  <E> boolean onSave(Object entity, Serializable id, Object[] state, String[] propertyNames, Type[] types);
}