---
name: development-workflow
description: "Bu skill, bir geliştirme sürecinde önce issue açma, sonra yeni branch oluşturma, geliştirme yapma ve sonunda PR açarak süreci tamamlama adımlarını yönetir. Geliştirme iş akışını (Issue -> Branch -> PR) otomatize etmek veya rehberlik etmek için kullanılır."
---

# Development Workflow Skill

Bu skill, projede standart bir geliştirme akışı uygulanmasını sağlar. İşlemleri aşağıdaki sırayla gerçekleştirir:

## 1. Issue Oluşturma
Bir işe başlanmadan önce mutlaka bir issue açılmalıdır.
- **Title**: Kısa, net ve açıklayıcı olmalıdır.
- **Labels**: İşin türüne göre `refactor`, `enhancement`, `test`, `bugfix` etiketlerinden biri seçilmelidir.
- **Description**: Yapılacak işin detayları ve kapsamı belirtilmelidir.

## 2. Branch Oluşturma
Issue açıldıktan sonra `main` branch üzerinden yeni bir branch oluşturulur.
- **İsimlendirme**: `etiket/kisa-tanim` formatında olmalıdır (Örn: `bugfix/login-error`, `enhancement/new-feature`, `test/login-tests`).
- **Kaynak**: Her zaman en güncel `main` branch'i temel alınmalıdır.

## 3. Geliştirme (Implementation)
İlgili branch üzerinde gerekli kod değişiklikleri, testler ve dokümantasyon güncellemeleri yapılır.

## 4. Pull Request (PR) Oluşturma
Geliştirme tamamlandığında `main` branch'ine geri dönmek için bir PR açılır.
- **Title**: Issue başlığı ile uyumlu, net bir tanım.
- **Description**: Yapılan değişikliklerin özeti ve "Closes #[issue-id]" veya "Fixes #[issue-id]" ibaresi eklenmelidir.
- **Labels**: Issue ile aynı etiketler kullanılmalıdır.

## Kullanım Talimatları
AI bu skill'i kullandığında kullanıcıya şu soruları sorabilir veya bu adımları takip eder:
1. "Hangi işi yapmak istiyorsunuz? (Kısa bir tanım ve tür: refactor/enhancement/test/bugfix)"
2. Issue açıldı bilgisini verir.
3. "Branch oluşturuluyor: [tür]/[kisa-tanim]"
4. Geliştirme adımlarına geçer.
5. Bitince PR açma adımını ve içeriğini onaylatır.
