// com/citywatch/service/TaskService.java
package com.citywatch.service;
import com.citywatch.dao.TaskDao;
import com.citywatch.model.Task;
import java.util.List;
public class TaskService {
 private final TaskDao taskDao = new TaskDao();
 public boolean claimTask(int taskId, int orgUserId) {
 // Enforce: only AVAILABLE tasks can be claimed
 return taskDao.claimTask(taskId, orgUserId);
 }
 public boolean completeTask(int taskId, int orgUserId) {
 // Enforce: only the assigned org can complete
 List<Task> orgTasks = taskDao.findByOrgId(orgUserId);
 boolean owns = orgTasks.stream().anyMatch(t -> t.getId() == taskId && "IN_PROGRESS".equals(t.getStatus()));
 if (!owns) return false;
 return taskDao.completeTask(taskId);
 }
}