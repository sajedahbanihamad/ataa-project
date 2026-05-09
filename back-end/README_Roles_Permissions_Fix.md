# Ataa Backend - Roles & Permissions Fixed

تم تعديل الـ backend حسب الـ Use Cases الموجودة بالملف:
- IndividualDonor / BusinessDonor: إنشاء وتعديل وإلغاء التبرعات الخاصة فيه فقط.
- Charity: مشاهدة التبرعات المعيّنة لها فقط، إنشاء reservation لها، تأكيد الاستلام، وتقييم donor بعد completion.
- تم منع الاعتماد على userId من الـ URL/body للعمليات الحساسة، والاعتماد صار على JWT token.
- تم إضافة/تقوية validation للـ register, donation, rating.
- تم إغلاق Users CRUD العام للـ Admin فقط حتى لا يستطيع أي مستخدم عادي الوصول له.
- تم تأمين Notifications بحيث كل مستخدم يرى ويعدل إشعاراته فقط.

ملاحظات مهمة:
1. شغّل migration/update database إذا احتجت، لكن أغلب التعديلات هنا Authorization/Validation/Business Logic وليست تعديلات DB.
2. في Swagger:
   - سجل مستخدم donor وخذ token.
   - اضغط Authorize وحط: Bearer YOUR_TOKEN
   - جرّب endpoints حسب role.
3. أي محاولة role غير مصرح له يجب أن تعطي 401/403 أو BadRequest حسب الحالة.
