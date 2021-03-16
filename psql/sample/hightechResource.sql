INSERT INTO public.resource (tenant_id, service_name, path, creator_id, display_name, description, tag, create_time, update_time)
  VALUES ($ tenantId, 'hightech', 'admin', $ creatorId, '高企审批管理员', '高企审批管理员', 'normal', NOW(), NOW())
