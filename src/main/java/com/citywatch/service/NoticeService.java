// com/citywatch/service/NoticeService.java
package com.citywatch.service;
 
import com.citywatch.dao.NoticeDao;
import com.citywatch.model.Notice;
 
import java.util.List;
 
public class NoticeService {
 
 private final NoticeDao noticeDao = new NoticeDao();
 
 public List<Notice> getRecentNotices(int limit) {
 return noticeDao.findRecent(limit);
 }
 
 public List<Notice> getAllNotices() {
 return noticeDao.findAll();
 }
 
 public boolean addNotice(String title, String description, int adminId) {
 Notice n = new Notice();
 n.setTitle(title);
 n.setDescription(description);
 n.setCreatedBy(adminId);
 return noticeDao.insertNotice(n);
 }
 
 public boolean updateNotice(int id, String title, String description) {
 Notice n = new Notice();
 n.setId(id);
 n.setTitle(title);
 n.setDescription(description);
 return noticeDao.updateNotice(n);
 }
 
 public boolean deleteNotice(int id) {
 return noticeDao.deleteNotice(id);
 }
}