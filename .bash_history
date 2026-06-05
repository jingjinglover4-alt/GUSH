exit
sed -n "1700,1710p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
sed -n "1870,1910p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
sed -n "396,430p" /opt/gush2/backend/apps/projects/views.py
exit
sed -n "185,200p" /opt/gush2/backend/templates/public_redeem.html
exit
grep -n ".hdr|.next-btn|page1-container|page1-container-inner" /opt/gush2/backend/templates/public_redeem.html | head -20
exit
grep -nE "hdr|next-btn|page1-container" /opt/gush2/backend/templates/public_redeem.html | head -20
exit
sed -n "175,200p" /opt/gush2/backend/templates/public_redeem.html
exit
sed -n "168,176p" /opt/gush2/backend/templates/public_redeem.html
exit
grep -nE "page-section|.page " /opt/gush2/backend/templates/public_redeem.html | head -10
exit
sed -n "34,40p" /opt/gush2/backend/templates/public_redeem.html
exit
python3 /tmp/apply_h5_position.py
exit
sed -n "1783,1800p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
sed -n "1886,1900p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
sed -n "1697,1710p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
grep -n "renderBlocks" /opt/gush2/backend/templates/public_redeem.html
exit
sed -n "380,420p" /opt/gush2/backend/templates/public_redeem.html
exit
sed -n "420,470p" /opt/gush2/backend/templates/public_redeem.html
exit
python3 /tmp/apply_h5_position.py
exit
grep -nE "header_position|button_position" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d --build 2>&1 | tail -20
exit
docker exec gush2-backend python3 -c "import requests,json;r=requests.post(chr(39)+chr(104)+chr(116)+chr(116)+chr(112)+chr(58)+chr(47)+chr(47)+chr(108)+chr(111)+chr(99)+chr(97)+chr(108)+chr(104)+chr(111)+chr(115)+chr(116)+chr(58)+chr(56)+chr(48)+chr(48)+chr(48)+chr(47)+chr(97)+chr(112)+chr(105)+chr(47)+chr(97)+chr(117)+chr(116)+chr(104)+chr(47)+chr(108)+chr(111)+chr(103)+chr(105)+chr(110)+chr(47)+chr(39),json={chr(39)+chr(117)+chr(115)+chr(101)+chr(114)+chr(110)+chr(97)+chr(109)+chr(101)+chr(39):chr(39)+chr(97)+chr(100)+chr(109)+chr(105)+chr(110)+chr(39),chr(39)+chr(112)+chr(97)+chr(115)+chr(115)+chr(119)+chr(111)+chr(114)+chr(100)+chr(39):chr(39)+chr(103)+chr(97)+chr(111)+chr(120)+chr(105)+chr(97)+chr(111)+chr(50)+chr(48)+chr(48)+chr(54)+chr(48)+chr(54)+chr(39)});tok=r.json().get(chr(39)+chr(116)+chr(111)+chr(107)+chr(101)+chr(110)+chr(39),chr(39)+chr(39));r2=requests.get(chr(39)+chr(104)+chr(116)+chr(116)+chr(112)+chr(58)+chr(47)+chr(47)+chr(108)+chr(111)+chr(99)+chr(97)+chr(108)+chr(104)+chr(111)+chr(115)+chr(116)+chr(58)+chr(56)+chr(48)+chr(48)+chr(48)+chr(47)+chr(97)+chr(112)+chr(105)+chr(47)+chr(112)+chr(97)+chr(103)+chr(101)+chr(115)+chr(47)+chr(104)+chr(53)+chr(47)+chr(63)+chr(112)+chr(114)+chr(111)+chr(106)+chr(101)+chr(99)+chr(116)+chr(61)+chr(50)+chr(39),headers={chr(39)+chr(65)+chr(117)+chr(116)+chr(104)+chr(111)+chr(114)+chr(105)+chr(122)+chr(97)+chr(116)+chr(105)+chr(111)+chr(110)+chr(39):chr(39)+chr(66)+chr(101)+chr(97)+chr(114)+chr(101)+chr(114)+chr(32)+chr(39)+tok});d=r2.json();print(d.get(chr(39)+chr(104)+chr(101)+chr(97)+chr(100)+chr(101)+chr(114)+chr(95)+chr(112)+chr(111)+chr(115)+chr(105)+chr(116)+chr(105)+chr(111)+chr(110)+chr(39)),d.get(chr(39)+chr(98)+chr(117)+chr(116)+chr(116)+chr(111)+chr(110)+chr(95)+chr(112)+chr(111)+chr(115)+chr(105)+chr(116)+chr(105)+chr(111)+chr(110)+chr(39)))"
exit
docker cp /tmp/verify_api.py gush2-backend:/tmp/verify_api.py && docker exec gush2-backend python3 /tmp/verify_api.py
exit
docker logs gush2-backend 2>&1 | tail -5
docker exec gush2-backend grep -r "pages/h5" /app/apps/ --include="*.py" -l 2>/dev/null
docker exec gush2-backend python3 -c "from django.urls import reverse; print(reverse(")" 2>&1 | head -5
exit
docker exec gush2-backend grep -rn "h5" /app/apps/pages/urls.py 2>/dev/null
docker exec gush2-backend cat /app/apps/pages/urls.py 2>/dev/null
exit
docker cp /tmp/verify_api.py gush2-backend:/tmp/verify_api.py && docker exec gush2-backend python3 /tmp/verify_api.py
exit
docker cp /tmp/verify_api.py gush2-backend:/tmp/verify_api.py && docker exec gush2-backend python3 /tmp/verify_api.py
exit
curl -s http://localhost/p/2/ 2>/dev/null | grep -E "header_position|button_position|applyPositions|hdrEl|btnEl" | head -5
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/ | grep -E "applyPositions|hdrPos|btnPos|hdrEl" | head -5
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/ | grep -E "position:|.hdr|.next-btn" | head -10
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/ | grep -A2 "page-section {"
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/ | grep -A5 "page-section {"
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/ | grep -B1 -A2 ".hdr { position"
exit
grep -nE "header_position|button_position|class H5Page" /opt/gush2/backend/apps/pages/serializers.py
exit
sed -n "50,75p" /opt/gush2/backend/apps/pages/serializers.py
exit
grep -n "def project_h5" /opt/gush2/backend/apps/pages/views.py
exit
sed -n "75,130p" /opt/gush2/backend/apps/pages/views.py
exit
sed -n "329,400p" /opt/gush2/backend/apps/projects/views.py
exit
grep -n "def resolve_h5" /opt/gush2/backend/apps/projects/views.py
exit
grep -rn "def resolve_h5" /opt/gush2/backend/
exit
sed -n "157,220p" /opt/gush2/backend/apps/pages/resolver.py
exit
grep -n "def resolve_h5" /opt/gush2/backend/apps/pages/resolver.py
exit
sed -n "1,156p" /opt/gush2/backend/apps/pages/resolver.py
exit
sed -n "396,420p" /opt/gush2/backend/apps/projects/views.py
exit
grep -nE "refreshPreview|previewUrl|iframe" /opt/gush2/frontend/src/views/projects/PageEditor.vue | head -20
exit
sed -n "1416,1435p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
grep -nE "saveH5|saveH5_Silent|@change|watch.*h5Form" /opt/gush2/frontend/src/views/projects/PageEditor.vue | head -20
exit
sed -n "1490,1510p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/?preview=1 | grep -A15 "class=.page-section" | head -25
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/?preview=1 | grep -A3 "applyPositions"
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/?preview=1 | grep -E "position:|.hdr {|.next-btn {" | head -10
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/?preview=1 | head -50
exit
docker cp /tmp/test_update_pos.py gush2-backend:/tmp/ && docker exec gush2-backend python3 /tmp/test_update_pos.py
exit
docker exec gush2-backend curl -s http://localhost:8000/p/2/?preview=1 | grep -E "hdrPos|btnPos"
exit
python3 /tmp/add_slider_change.py
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d --build 2>&1 | tail -15
exit
docker cp /tmp/reset_pos.py gush2-backend:/tmp/ && docker exec gush2-backend python3 /tmp/reset_pos.py
exit
sed -n "213,270p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
python3 /tmp/fix_style_controls.py
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d --build 2>&1 | tail -10
exit
grep -nE "header_style|page1_button_style|page1_button_font|page1_button_bg|page1_button_padding|header_color|header_font" /opt/gush2/backend/apps/pages/models.py | head -20
exit
grep -nE "header_style|header_color|header_font" /opt/gush2/backend/apps/pages/resolver.py | head -10
exit
grep -n "header_style|page1_button_style" /opt/gush2/backend/apps/pages/resolver.py
exit
grep -nE "header_style|page1_button_style" /opt/gush2/backend/apps/pages/resolver.py
exit
cat /opt/gush2/backend/apps/pages/resolver.py | head -50
exit
grep -n "header_style|page1_button_style" /opt/gush2/backend/apps/pages/resolver.py
grep -n "header_style|page1_button_style" /opt/gush2/backend/apps/pages/models.py
exit
grep -nE "header_style|page1_button_style" /opt/gush2/backend/apps/pages/resolver.py /opt/gush2/backend/apps/pages/models.py /opt/gush2/backend/apps/pages/serializers.py
exit
grep -n "def _h5_to_dict" /opt/gush2/backend/apps/pages/resolver.py
exit
sed -n "71,120p" /opt/gush2/backend/apps/pages/resolver.py
exit
python3 /tmp/fix_style_mapping.py
exit
sed -n "1800,1820p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
sed -n "1908,1925p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
python3 /tmp/fix_style_mapping.py
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d --build 2>&1 | tail -10
exit
grep -rnE "redeem|claim|兑换" /opt/gush2/backend/apps/projects/urls.py /opt/gush2/backend/apps/devices/urls.py 2>/dev/null
exit
grep -rnE "redeem|submit" /opt/gush2/backend/apps/projects/views.py | head -20
exit
grep -nE "path.*redeem|path.*claim|path.*submit|path.*code" /opt/gush2/backend/apps/projects/urls.py /opt/gush2/backend/urls.py 2>/dev/null
exit
cat /opt/gush2/backend/apps/projects/urls.py
exit
cat /opt/gush2/backend/urls.py
exit
find /opt/gush2/backend -name "urls.py" -path "*/config/*" 2>/dev/null
cat /opt/gush2/backend/config/urls.py 2>/dev/null || find /opt/gush2/backend -maxdepth 2 -name urls.py
exit
cat /opt/gush2/backend/gush/urls.py
exit
sed -n "439,600p" /opt/gush2/backend/apps/projects/views.py
exit
sed -n "439,500p" /opt/gush2/backend/apps/projects/views.py
exit
docker logs gush2-nginx 2>&1 | tail -10
curl -s -o /dev/null -w "%{http_code}" https://admin.gush.cdgushai.com/
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod build nginx 2>&1 | tail -20
exit
grep -c "page1_button_font_size" /opt/gush2/frontend/src/views/projects/PageEditor.vue
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod build --no-cache nginx 2>&1 | tail -25
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d
exit
docker logs gush2-nginx 2>&1 | tail -30
exit
docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | grep -i page | head -10
docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | tail -20
exit
docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | grep -i editor
docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | grep -i page
exit
docker exec gush2-nginx head -c 500 /usr/share/nginx/html/assets/PageEditor-bQZO8SwS.js
exit
grep -nE "page-editor|PageEditor|pageEditor" /opt/gush2/frontend/src/router/ -r
exit
grep -nE "页面装修|用户获取|page-editor|leads|router-link" /opt/gush2/frontend/src/views/projects/ProjectDetail.vue | head -20
exit
sed -n "28,50p" /opt/gush2/frontend/src/views/projects/ProjectDetail.vue
exit
grep -E "page-editor|leads|projects/2" /opt/gush2/docker/nginx/nginx.conf
exit
grep -nE "try_files|location.*projects" /opt/gush2/docker/nginx/nginx.conf | head -10
exit
grep -nE "页面装修|用户获取|el-menu|el-sub-menu" /opt/gush2/frontend/src/views/projects/ProjectDetail.vue | head -20
exit
grep -nE "页面装修|用户获|MagicStick|page-editor|/leads" /opt/gush2/frontend/src/ -r --include="*.vue" --include="*.js" | head -20
exit
grep -rn "用户获取|用户获客" /opt/gush2/frontend/src/ --include="*.vue" --include="*.js" | head -10
exit
grep -rn "leads" /opt/gush2/frontend/src/layouts/ -l
grep -n "leads" /opt/gush2/frontend/src/layouts/*.vue 2>/dev/null | head -10
exit
ls /opt/gush2/frontend/src/
exit
grep -n "el-menu|sidebar|aside" /opt/gush2/frontend/src/App.vue | head -10
exit
sed -n "1,30p" /opt/gush2/frontend/src/views/projects/ProjectDetail.vue
exit
grep -n "el-row|el-col|el-aside|el-container|sidebar" /opt/gush2/frontend/src/views/projects/ProjectDetail.vue | head -10
exit
grep -nE "el-row|el-col|el-aside|el-container|sidebar" /opt/gush2/frontend/src/App.vue | head -10
exit
cat /opt/gush2/frontend/src/App.vue
exit
grep -n "meta|title" /opt/gush2/frontend/src/router/index.js | head -30
exit
cat /opt/gush2/frontend/src/router/index.js
exit
head -40 /opt/gush2/frontend/src/router/index.js
exit
cat /opt/gush2/frontend/src/views/Layout.vue
exit
head -120 /opt/gush2/frontend/src/views/Layout.vue
exit
cat /opt/gush2/frontend/src/views/ProjectDetail.vue | head -10
exit
ls /opt/gush2/frontend/src/views/projects/
exit
head -60 /opt/gush2/frontend/src/views/projects/ProjectDetail.vue
exit
docker logs gush2-nginx 2>&1 | grep -E "page-editor|leads|500|404|error" | tail -20
exit
docker exec gush2-nginx grep -c "page1_button_font_size" /usr/share/nginx/html/assets/index-B3MsOdnm.js
docker exec gush2-nginx grep -c "page1_button_font_size" /usr/share/nginx/html/assets/projects-SQfPvFfk.js
exit
docker exec gush2-nginx grep -c "page1_button_font_size" /usr/share/nginx/html/assets/PageEditor-*.js
docker exec gush2-nginx grep -c "page1_button_font_size" /usr/share/nginx/html/assets/pages-*.js
exit
docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | grep -i pageeditor
exit
docker exec gush2-nginx grep -c page1_button_font_size /usr/share/nginx/html/assets/PageEditor-bQZO8SwS.js
exit
grep -A5 "header_style:" /opt/gush2/frontend/src/views/projects/PageEditor.vue | head -20
exit
grep -B2 -A10 "page1_button_style: {" /opt/gush2/frontend/src/views/projects/PageEditor.vue | head -30
exit
docker cp /tmp/verify_h5_fields.py gush2-backend:/tmp/ && docker exec gush2-backend python3 /tmp/verify_h5_fields.py
exit
docker cp gush2-nginx:/usr/share/nginx/html/index.html /tmp/index.html && sed -i "s|/assets/|/assets/?v=20260527|g" /tmp/index.html && docker cp /tmp/index.html gush2-nginx:/usr/share/nginx/html/index.html
exit
grep -nE "page1_button_font|header_font" /opt/gush2/backend/apps/pages/models.py
exit
grep -n "header_font|header_color|header_style" /opt/gush2/backend/apps/pages/models.py
exit
grep -nE "header_font|header_color|header_style" /opt/gush2/backend/apps/pages/models.py
exit
python3 /tmp/add_header_fields.py
exit
python3 /tmp/add_header_fields.py
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend python manage.py makemigrations pages && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend python manage.py migrate
exit
grep -n "header_font|header_position|button_position|header_font_color|header_font_size" /opt/gush2/backend/apps/pages/models.py | head -10
exit
grep -nE "header_font|header_position|button_position" /opt/gush2/backend/apps/pages/models.py
exit
ls /opt/gush2/backend/apps/pages/migrations/ | grep "\.py$" | sort | tail -5
exit
cp /tmp/0013_h5page_header_font.py /opt/gush2/backend/apps/pages/migrations/ && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend python manage.py migrate pages
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend python manage.py migrate pages
exit
ls -la /opt/gush2/backend/apps/pages/migrations/ | grep "\.py$" | sort
exit
grep -E "button_position|header_position" /opt/gush2/backend/apps/pages/migrations/0011*.py /opt/gush2/backend/apps/pages/migrations/0012*.py
exit
grep "button_position|header_position" /opt/gush2/backend/apps/pages/migrations/0011*.py /opt/gush2/backend/apps/pages/migrations/0012*.py
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend python manage.py showmigrations pages
exit
ls /opt/gush2/backend/apps/pages/migrations/0013*
cat /opt/gush2/backend/apps/pages/migrations/0013_h5page_button_position_h5page_header_position_and_more.py
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend ls /app/apps/pages/migrations/0013*
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend find /app/apps/pages/migrations/ -name "0013*"
exit
grep -A5 "backend" /opt/gush2/docker-compose.prod.yml | grep -E "volume|.env"
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend rm /app/apps/pages/migrations/0013_h5page_button_position_h5page_header_position_and_more.py
docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend ls /app/apps/pages/migrations/ | grep 0013
exit
ls /opt/gush2/backend/apps/pages/migrations/ | grep 0013
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend ls /app/apps/pages/migrations/ | grep 0013
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend python manage.py migrate pages
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend python manage.py showmigrations pages
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend ls /app/apps/pages/migrations/*.py | grep 0013
exit
cat /opt/gush2/backend/Dockerfile 2>/dev/null || cat /opt/gush2/backend/Dockerfile.prod 2>/dev/null
exit
grep -A20 "backend:" /opt/gush2/docker-compose.prod.yml | grep -E "volume|mount"
exit
docker inspect gush2-backend --format="{{json .Mounts}}" | python3 -m json.tool | grep -A5 Source
exit
python3 -c "open(/tmp/0013_h5page_header_font.py,w).write(open(/tmp/0013_h5page_header_font.py).read())" 2>/dev/null; docker cp /tmp/0013_h5page_header_font.py gush2-backend:/tmp/0013_h5page_header_font.py
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend cp /tmp/0013_h5page_header_font.py /app/apps/pages/migrations/ && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend python manage.py migrate pages
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d --build 2>&1 | tail -10
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod build --no-cache nginx 2>&1 | grep -E "error|Error|ERROR|warning" | tail -20
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod build --no-cache nginx 2>&1 | tail -40
exit
grep -n "header_font_color: h5Form" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
sed -n "1812,1830p" /opt/gush2/frontend/src/views/projects/PageEditor.vue
exit
python3 /tmp/fix_broken_js.py
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod build --no-cache nginx 2>&1 | tail -5
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d && sleep 3 && docker cp gush2-nginx:/usr/share/nginx/html/index.html /tmp/index.html && sed -i "s|v=20260527|v=20260527b|g" /tmp/index.html && docker cp /tmp/index.html gush2-nginx:/usr/share/nginx/html/index.html
exit
docker cp /tmp/verify_h5_fields.py gush2-backend:/tmp/verify_h5_fields.py && docker exec gush2-backend python3 /tmp/verify_h5_fields.py
exit
sleep 5 && docker exec gush2-backend curl -s http://localhost:8000/api/health/
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d --build backend 2>&1 | tail -15
exit
sleep 3 && docker exec gush2-backend curl -s http://localhost:8000/api/health/
exit
docker logs gush2-backend 2>&1 | tail -20
exit
sed -n "252,262p" /opt/gush2/backend/apps/pages/models.py
exit
sed -i "s|^        page1_button_font_size|    page1_button_font_size|" /opt/gush2/backend/apps/pages/models.py
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d --build backend 2>&1 | tail -10
exit
sleep 5 && docker exec gush2-backend curl -s http://localhost:8000/api/health/
exit
docker cp /tmp/verify_h5_fields.py gush2-backend:/tmp/verify_h5_fields.py && docker exec gush2-backend python3 /tmp/verify_h5_fields.py
exit
docker exec gush2-backend python3 -c "import requests,json;r=requests.post(chr(39)+chr(104)+chr(116)+chr(116)+chr(112)+chr(58)+chr(47)+chr(47)+chr(108)+chr(111)+chr(99)+chr(97)+chr(108)+chr(104)+chr(111)+chr(115)+chr(116)+chr(58)+chr(56)+chr(48)+chr(48)+chr(48)+chr(47)+chr(97)+chr(112)+chr(105)+chr(47)+chr(97)+chr(117)+chr(116)+chr(104)+chr(47)+chr(108)+chr(111)+chr(103)+chr(105)+chr(110)+chr(47)+chr(39),json={chr(39)+chr(117)+chr(115)+chr(101)+chr(114)+chr(110)+chr(97)+chr(109)+chr(101)+chr(39):chr(39)+chr(97)+chr(100)+chr(109)+chr(105)+chr(110)+chr(39),chr(39)+chr(112)+chr(97)+chr(115)+chr(115)+chr(119)+chr(111)+chr(114)+chr(100)+chr(39):chr(39)+chr(103)+chr(97)+chr(111)+chr(120)+chr(105)+chr(97)+chr(111)+chr(50)+chr(48)+chr(48)+chr(54)+chr(48)+chr(54)+chr(39)});tok=r.json().get(chr(39)+chr(97)+chr(99)+chr(99)+chr(101)+chr(115)+chr(115)+chr(39),chr(39)+chr(39));d=requests.get(chr(39)+chr(104)+chr(116)+chr(116)+chr(112)+chr(58)+chr(47)+chr(47)+chr(108)+chr(111)+chr(99)+chr(97)+chr(108)+chr(104)+chr(111)+chr(115)+chr(116)+chr(58)+chr(56)+chr(48)+chr(48)+chr(48)+chr(47)+chr(97)+chr(112)+chr(105)+chr(47)+chr(112)+chr(114)+chr(111)+chr(106)+chr(101)+chr(99)+chr(116)+chr(115)+chr(47)+chr(50)+chr(47)+chr(104)+chr(53)+chr(47)+chr(39),headers={chr(39)+chr(65)+chr(117)+chr(116)+chr(104)+chr(111)+chr(114)+chr(105)+chr(122)+chr(97)+chr(116)+chr(105)+chr(111)+chr(110)+chr(39):chr(39)+chr(66)+chr(101)+chr(97)+chr(114)+chr(101)+chr(114)+chr(32)+chr(39)+tok});print(d.json().get(chr(39)+chr(104)+chr(101)+chr(97)+chr(100)+chr(101)+chr(114)+chr(95)+chr(102)+chr(111)+chr(110)+chr(116)+chr(95)+chr(99)+chr(111)+chr(108)+chr(111)+chr(114)+chr(39)),d.json().get(chr(39)+chr(104)+chr(101)+chr(97)+chr(100)+chr(101)+chr(114)+chr(95)+chr(102)+chr(111)+chr(110)+chr(116)+chr(95)+chr(115)+chr(105)+chr(122)+chr(101)+chr(39)))"
exit
docker cp /tmp/verify_header.py gush2-backend:/tmp/ && docker exec gush2-backend python3 /tmp/verify_header.py
exit
sed -n "496,600p" /opt/gush2/backend/apps/projects/views.py
exit
sed -n "496,550p" /opt/gush2/backend/apps/projects/views.py
exit
python3 /tmp/add_qt_api.py
exit
grep -n "qt-exchange" /opt/gush2/backend/gush/urls.py
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod exec backend bash -c "grep -n qt-exchange /app/gush/urls.py || echo NOT_FOUND"
exit
grep -n "public_redeem_submit" /opt/gush2/backend/gush/urls.py
exit
sed -i "s|path(\"api/public/redeem/\", public_redeem_submit, name=\"public-redeem-submit\"),|path(\"api/public/redeem/\", public_redeem_submit, name=\"public-redeem-submit\"),\n    path(\"api/public/redeem/api/exchange/\", qt_exchange, name=\"qt-exchange\"),\n    path(\"api/public/redeem/api/report/\", qt_report, name=\"qt-report\"),|" /opt/gush2/backend/gush/urls.py
exit
grep -n "qt_exchange|qt_report|qt-exchange" /opt/gush2/backend/gush/urls.py
exit
python3 /tmp/fix_urls.py
exit
grep -c qt_exchange /opt/gush2/backend/gush/urls.py
grep -n qt_exchange /opt/gush2/backend/gush/urls.py
exit
cd /opt/gush2 && docker compose -f docker-compose.prod.yml --env-file .env.prod up -d --build backend 2>&1 | tail -10
exit
sleep 5 && docker exec gush2-backend curl -s -X POST http://localhost:8000/api/public/redeem/api/exchange/ -H "Content-Type: application/json" -d {"code":"TEST123"}
exit
docker logs gush2-backend 2>&1 | tail -15
exit
grep -n radio-group /opt/gush2/backend/templates/public_redeem.html
grep -n multi-group /opt/gush2/backend/templates/public_redeem.html
exit
sed -i "s/.multi-group { display: flex; flex-direction: column; gap: 8px; }/.multi-group { display: flex; flex-direction: column; gap: 10px; }/" /opt/gush2/backend/templates/public_redeem.html
grep -n multi-group /opt/gush2/backend/templates/public_redeem.html
docker restart gush2-backend
yaoyao1986630!
grep -n "radio-opt|multi-opt|radio-group|multi-group|gap" /opt/gush2/backend/templates/public_redeem.html
exit
sed -n "70,100p" /opt/gush2/backend/templates/public_redeem.html
exit
sudo docker logs gush2-backend --tail 50 2>&1 | grep -i -E "websocket|error|500|channels|consumer" | tail -20
exit
cat /opt/gush2/backend/gush2/asgi.py
exit
cat /opt/gush2/backend/gush2/routing.py 2>/dev/null || echo NO_ROUTING_PY; find /opt/gush2/backend -name "routing*" -o -name "consumer*" 2>/dev/null
exit
cat /etc/nginx/conf.d/gush2.conf 2>/dev/null || sudo cat /etc/nginx/conf.d/gush2.conf 2>/dev/null || echo NO_NGINX_CONF
exit
cat /opt/gush2/backend/apps/devices/routing.py
cat /opt/gush2/backend/apps/devices/consumers.py
find /opt/gush2/backend -name "asgi*" 2>/dev/null
exit
sudo find /etc/nginx -name "*.conf" -exec grep -l gush {} ; 2>/dev/null
sudo cat /opt/gush2/nginx/gush2.conf 2>/dev/null || sudo cat /opt/gush2/docker/nginx/default.conf 2>/dev/null || echo NO_NGINX
exit
cat /opt/gush2/backend/gush/asgi.py
cat /opt/gush2/backend/gush/settings.py | grep -i -E "channels|asgi|channel_layer|redis" | head -20
exit
sudo docker exec gush2-backend cat /etc/nginx/conf.d/default.conf 2>/dev/null; sudo find /opt/gush2 -path "*/nginx*" -name "*.conf" 2>/dev/null; sudo cat /opt/gush2/docker/nginx/nginx.conf 2>/dev/null
exit
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHojAd4cU3MielNFDcZfxM05jB5JY/9eE7/6fW+wSt1J claude-ai' >> ~/.ssh/authorized_keys
sed -n "40,100p" /opt/gush2/backend/templates/public_redeem.html
exit
cd /opt/gush2/backend/templates && cp public_redeem.html public_redeem.html.bak
sed -i "s/padding: 12px;$/padding: 10px 12px;/" public_redeem.html
sed -i "s|border: 1.5px solid var(--panel-border);|border: 1px solid var(--panel-border);|g" public_redeem.html
sed -i "s/border-radius: 12px; cursor: pointer;/border-radius: 10px; cursor: pointer;/" public_redeem.html
sed -i "s|background: rgba(255,255,255,0.04)|background: rgba(255,255,255,0.06)|g" public_redeem.html
grep -n "radio-opt|multi-opt" public_redeem.html | head -10
sudo docker restart gush2-backend
cd /opt/gush2 && ls docker-compose.prod.yml .env.prod 2>&1
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build 2>&1
pkill -9 -f "docker buildx build" 2>/dev/null; pkill -9 -f "docker compose build" 2>/dev/null; pkill -9 -f "docker build" 2>/dev/null; sudo docker ps -a 2>&1 | head -20
exit
sudo docker images gush2-nginx gush2-backend --format "{{.Repository}} {{.Tag}} {{.CreatedAt}}" 2>&1
exit
sudo docker images --format "{{.Repository}} {{.Tag}} {{.CreatedAt}}" 2>&1
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d nginx 2>&1
exit
sudo docker ps --format "{{.Names}} {{.Status}}" 2>&1
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build backend 2>&1
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d backend 2>&1
exit
sudo docker logs gush2-backend --tail 15 2>&1
exit
ls /opt/gush2/backend/apps/devices/ 2>&1
exit
grep -n "MACHINE\|machine_id\|machine_code\|编号" /opt/gush2/backend/apps/devices/models.py | head -20
exit
sed -n "140,170p" /opt/gush2/backend/apps/devices/models.py
exit
cp /opt/gush2/backend/apps/devices/models.py /opt/gush2/backend/apps/devices/models.py.bak
exit
python3 << "PYEOF"
import re
path = "/opt/gush2/backend/apps/devices/models.py"
with open(path) as f:
    content = f.read()

old = "        # 生成自增编号\n        last = cls.objects.select_for_update().order_by(\"-id\").first()\n        next_seq = (last.id + 1) if last else 1\n        machine_id = f\"MACHINE{next_seq:03d}\""
new = "        # 补空缺编号：扫描所有 MACHINE 编号，找最小未使用的序号\n        existing_nums = set()\n        for mid in cls.objects.values_list(\"machine_id\", flat=True):\n            m = re.match(r\"^MACHINE(\\d+)$\", mid or \"\")\n            if m:\n                existing_nums.add(int(m.group(1)))\n        next_seq = 1\n        while next_seq in existing_nums:\n            next_seq += 1\n        machine_id = f\"MACHINE{next_seq:03d}\""

if old not in content:
    print("OLD NOT FOUND")
else:
    content = content.replace(old, new)
    with open(path, "w") as f:
        f.write(content)
    print("OK")
PYEOF

exit
grep -n "^import re\|^import" /opt/gush2/backend/apps/devices/models.py | head -5
exit
sed -i "s/^import secrets/import re\nimport secrets/" /opt/gush2/backend/apps/devices/models.py && head -15 /opt/gush2/backend/apps/devices/models.py
exit
sed -n "148,170p" /opt/gush2/backend/apps/devices/models.py
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build backend 2>&1 | tail -3
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d backend 2>&1 | tail -3 && sudo docker logs gush2-backend --tail 5 2>&1 | tail -5
exit
grep -rn "bound_project" /opt/gush2/backend/apps/ 2>/dev/null | head -10
exit
sed -n "20,80p" /opt/gush2/backend/apps/devices/serializers.py
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build nginx 2>&1 | tail -3
exit
ls -la /opt/gush2/frontend/dist/index.html 2>&1 && cat /opt/gush2/frontend/dist/index.html 2>/dev/null | head -3
exit
ls -la /opt/gush2/frontend/dist/index.html
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build nginx 2>&1 | tail -3
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d nginx 2>&1 | tail -3
exit
cat /opt/gush2/docker/nginx/Dockerfile.prod 2>&1; ls /opt/gush2/docker/nginx/ 2>&1
exit
find /opt/gush2 -name "Dockerfile*" 2>/dev/null
exit
cat /opt/gush2/frontend/Dockerfile.prod
exit
grep -c "绑定项目" /opt/gush2/frontend/src/views/devices/DeviceList.vue
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build nginx --no-cache 2>&1 | tail -10
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d nginx 2>&1 | tail -3
exit
sudo docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | grep DeviceList
exit
ls -la /opt/gush2/backend/apps/devices/models.py.bak /opt/gush2/backend/templates/public_redeem.html.bak 2>&1
exit
cp /opt/gush2/backend/apps/devices/models.py.bak /opt/gush2/backend/apps/devices/models.py && cp /opt/gush2/backend/templates/public_redeem.html.bak /opt/gush2/backend/templates/public_redeem.html && echo OK && head -10 /opt/gush2/backend/apps/devices/models.py && echo --- && grep -c "补空缺\|^import re" /opt/gush2/backend/apps/devices/models.py && echo --- && head -5 /opt/gush2/backend/templates/public_redeem.html
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build backend 2>&1 | tail -3 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d backend 2>&1 | tail -3 && sudo docker logs gush2-backend --tail 5 2>&1 | tail -5
exit
ls /opt/gush2/ 2>&1 && echo --- && ls /opt/gush2/backend/ 2>&1
exit
ls /opt/gush2/backend/apps/ 2>&1
exit
ls /tmp/backup_apps/ && echo --- && ls /tmp/backup_templates/ && echo --- && ls /tmp/backup_apps/devices/ 2>&1 | head -5
exit
echo === APPS DIFF === && diff -rq /tmp/backup_apps/ /opt/gush2/backend/apps/ 2>&1 | head -40 && echo === TEMPLATES DIFF === && diff -rq /tmp/backup_templates/ /opt/gush2/backend/templates/ 2>&1 | head -40
exit
diff /tmp/backup_apps/devices/views.py /opt/gush2/backend/apps/devices/views.py | head -40
exit
head -10 /opt/gush2/backend/apps/devices/models.py && echo --- && ls /opt/gush2/backend/apps/projects/clear_daily_claims.py 2>&1 && ls /opt/gush2/backend/apps/projects/migrations/0005_claim_daily_record.py 2>&1 && ls /opt/gush2/backend/apps/projects/management/ 2>&1
exit
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build backend 2>&1 | tail -3 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d backend 2>&1 | tail -3 && sleep 3 && sudo docker logs gush2-backend --tail 8 2>&1 | tail -10
exit
sudo docker ps --format "{{.Names}} {{.Status}}" 2>&1 && curl -sI https://admin.gush.cdgushai.com/ -k | head -2
exit
grep -n "page1\|page2\|位置\|page_section\|padding\|margin" /opt/gush2/backend/templates/public_redeem.html | head -30
exit
sudo docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | head -20 && echo --- && sudo docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | grep -E "PageEditor|index-" | head -5
exit
sed -n '1,80p;160,260p' /opt/gush2/backend/apps/devices/consumers.py
grep -rn 'motor_run\|send_command\|device_command' /opt/gush2/backend/ --include='*.py' 2>/dev/null
sed -n '570,620p' /opt/gush2/backend/apps/pages/views.py
cd /home/ubuntu/gush-project
find . -name '._*' -delete; find . -name '*.py.bak' -delete; find . -name '*.pyc' -delete; find . -name __pycache__ -type d -exec rm -rf {} + 2>/dev/null; echo 'cleaned'
echo '__SCRIPT_B64_PLACEHOLDER__' > /tmp/check.b64
cat > /tmp/check.sh << 'REMOTE_EOF'
echo ===A.DNS_MACHINE001===
dig +short machine001.gush.cdgushai.com @8.8.8.8 2>&1
echo ---nslookup---
nslookup machine001.gush.cdgushai.com 8.8.8.8 2>&1 | tail -10
echo ===B.DNS_GUSH_ADMIN===
dig +short gush.cdgushai.com @8.8.8.8 2>&1
dig +short admin.gush.cdgushai.com @8.8.8.8 2>&1
echo ===C.LOCAL_RESOLVE===
cat /etc/resolv.conf
echo ---hosts---
cat /etc/hosts
echo ===D.curl===
curl -sk -o /dev/null -w 'admin=%{http_code}\n' https://admin.gush.cdgushai.com/ 2>&1
curl -sk -o /dev/null -w 'machine001=%{http_code}\n' https://machine001.gush.cdgushai.com/ 2>&1
echo ===E.nginx_conf_dir===
ls /opt/gush2/docker/nginx/ 2>&1
ls /opt/gush2/docker/nginx/conf.d/ 2>&1
echo ---conf_files---
for f in /opt/gush2/docker/nginx/conf.d/*.conf /opt/gush2/docker/nginx/nginx.conf; do
  if [ -f "$f" ]; then echo "---FILE: $f---"; cat "$f"; fi
done
echo ===F.docker_ps===
sudo docker ps --format 'table {{.Names}}{{.Status}}{{.Ports}}' 2>&1
echo ===G.machine001_in_db===
sudo docker exec gush2-mysql mysql -ugush -pgush_password gush2 -e "SELECT id, code, subdomain, status, last_seen FROM machines WHERE subdomain LIKE 'machine%' LIMIT 5;" 2>&1
echo ===H.END===
REMOTE_EOF

bash /tmp/check.sh
cat > /tmp/check2.sh << 'REMOTE_EOF'
echo ===FIND_ENV===
sudo find / -maxdepth 4 -name "*.env*" 2>/dev/null | grep -E "gush|prod" | head -20
echo ===PWD===
pwd
ls -la /opt/ 2>&1
ls -la ~ 2>&1
echo ===COMPOSE===
ls /opt/gush2/ 2>&1 || find / -maxdepth 3 -name "docker-compose*.yml" 2>/dev/null | head
echo ===MYSQL_PASSWORD===
grep -rE "MYSQL_ROOT_PASSWORD|MYSQL_PASSWORD|DATABASE_URL" /opt/gush2/ 2>/dev/null | head
echo ===CHECK_MACHINE001===
sudo docker exec gush2-mysql env 2>&1 | grep -iE "mysql|password" | sed 's/PASSWORD=.*/PASSWORD=***/'
echo ===DOCKER_INSPECT===
sudo docker inspect gush2-mysql --format '{{range .Config.Env}}{{println .}}{{end}}' 2>&1 | grep -iE "mysql|password" | sed 's/PASSWORD=.*/PASSWORD=***/'
echo ===H.END===
REMOTE_EOF

bash /tmp/check2.sh
exit
cat > /tmp/check3.sh << 'REMOTE_EOF'
echo ===A.MACHINE001===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT id, code, subdomain, status, is_active, last_seen, last_heartbeat, ip_address, mac_address, network_type, created_at, updated_at FROM machines WHERE subdomain LIKE '%machine001%' OR code='machine001' OR code LIKE 'machine001%' LIMIT 5\\G" 2>&1 | grep -v "Warning"
echo ===B.ALL_MACHINES_BRIEF===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT id, code, subdomain, status, is_active, last_seen FROM machines ORDER BY id LIMIT 30;" 2>&1 | grep -v "Warning"
echo ===C.TABLES===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SHOW TABLES;" 2>&1 | grep -v "Warning"
echo ===D.MACHINE_COLUMNS===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "DESCRIBE machines;" 2>&1 | grep -v "Warning"
echo ===H.END===
REMOTE_EOF

bash /tmp/check3.sh
exit
cat > /tmp/check4.sh << 'REMOTE_EOF'
echo ===A.DESCRIBE===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "DESCRIBE gush_machine;" 2>&1 | grep -v "Warning"
echo ===B.MACHINE001===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT * FROM gush_machine WHERE code='machine001' OR subdomain LIKE '%machine001%' LIMIT 5\\G" 2>&1 | grep -v "Warning"
echo ===C.ALL_MACHINES===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT id, code, subdomain, status, is_active, last_seen, last_heartbeat_at, ip_address, network_type FROM gush_machine ORDER BY id;" 2>&1 | grep -v "Warning"
echo ===D.HEARTBEAT_LOG_LATEST_5===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT id, machine_id, created_at, ip, rssi, network_type, payload FROM gush_heartbeat_log WHERE machine_id IN (SELECT id FROM gush_machine WHERE code='machine001' OR subdomain LIKE '%machine001%') ORDER BY id DESC LIMIT 5\\G" 2>&1 | grep -v "Warning"
echo ===H.END===
REMOTE_EOF

bash /tmp/check4.sh
exit
cat > /tmp/check5.sh << 'REMOTE_EOF'
echo ===A.DESCRIBE_HEARTBEAT===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "DESCRIBE gush_heartbeat_log;" 2>&1 | grep -v "Warning"
echo ===B.MACHINE001_BY_SUBDOMAIN===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT * FROM gush_machine WHERE subdomain LIKE '%machine001%'\\G" 2>&1 | grep -v "Warning"
echo ===C.ALL_MACHINES_BRIEF===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT machine_id, subdomain, name, status, last_heartbeat_at, signal_strength, network_type, network_plan, carrier, iccid, wifi_ssid FROM gush_machine ORDER BY machine_id;" 2>&1 | grep -v "Warning"
echo ===D.HEARTBEAT_LATEST_5_FOR_MACHINE001===
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT * FROM gush_heartbeat_log WHERE machine_id IN (SELECT machine_id FROM gush_machine WHERE subdomain LIKE '%machine001%') ORDER BY id DESC LIMIT 5\\G" 2>&1 | grep -v "Warning"
echo ===H.END===
REMOTE_EOF

bash /tmp/check5.sh
exit
cat > /tmp/snap.sh << 'REMOTE_EOF'
set -e
TS=$(date +%Y%m%d-%H%M%S)
echo "===SNAPSHOT===" $TS
SNAP_DIR="/home/ubuntu/gush2-snapshots/$TS"
mkdir -p "$SNAP_DIR"

# 1. 关键目录时间点快照（不动原文件，只打包）
echo ---A.snapshot_files---
cd /opt/gush2
tar czf "$SNAP_DIR/frontend-src.tar.gz" frontend/src 2>&1
tar czf "$SNAP_DIR/nginx-conf.tar.gz" docker/nginx 2>&1

# 2. 当前 gush2-nginx 容器内构建产物哈希（用容器名作标签）
echo ---B.nginx_container---
sudo docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" 2>&1 | grep nginx

# 3. 现有前端镜像 tag
echo ---C.nginx_image---
sudo docker images gush2-nginx --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}" 2>&1

# 4. 当前 PageEditor.vue 在服务器上的 mtime + size
echo ---D.online_PageEditor---
ls -la /opt/gush2/frontend/src/views/projects/PageEditor.vue 2>&1
md5sum /opt/gush2/frontend/src/views/projects/PageEditor.vue 2>&1

echo "SNAP_DIR=$SNAP_DIR" > /tmp/snap_env
echo ===H.END===
REMOTE_EOF

bash /tmp/snap.sh
ls -la /home/ubuntu/gush2-snapshots/20260602-222329/ 2>&1; echo ---tar_listing---; tar tzf /home/ubuntu/gush2-snapshots/20260602-222329/frontend-src.tar.gz 2>&1 | head -5; echo ---size---; du -sh /home/ubuntu/gush2-snapshots/20260602-222329/*.tar.gz 2>&1; exit
rm -f /tmp/PageEditor.vue.new; touch /tmp/PageEditor.vue.new
base64 -d > /tmp/PageEditor.vue.new << B64END
B64END

ls -la /tmp/PageEditor.vue.new 2>&1; exit
rm -f /tmp/PageEditor.vue.new.b64 /tmp/PageEditor.vue.new; touch /tmp/PageEditor.vue.new.b64
cat > /tmp/PageEditor.vue.new.b64 << B64EOF
PHRlbXBsYXRlPgogIDxkaXYgdi1sb2FkaW5nPSJsb2FkaW5nIiBjbGFzcz0icGFnZS1lZGl0b3IiPgogICAgPCEtLSDpobbmoI8gLS0+CiAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iaGRyLWNhcmQiPgogICAgICA8ZGl2IGNsYXNzPSJoZHIiPgogICAgICAgIDxlbC1idXR0b24gOmljb249IkFycm93TGVmdCIgbGluayBAY2xpY2s9IiRyb3V0ZXIucHVzaChgL3Byb2plY3RzLyR7cHJvamVjdElkfWApIj7ov5Tlm57pobnnm648L2VsLWJ1dHRvbj4KICAgICAgICA8c3BhbiBjbGFzcz0idGl0bGUiPnt7IHByb2plY3Q/Lm5hbWUgfHwgJ+mhtemdouijheS/ricgfX08L3NwYW4+CiAgICAgICAgPGVsLXRhZyBzaXplPSJzbWFsbCIgOnR5cGU9ImN1cnJlbnRTdGF0dXMgPT09ICdwdWJsaXNoZWQnID8gJ3N1Y2Nlc3MnIDogJ3dhcm5pbmcnIj4KICAgICAgICAgIHt7IGN1cnJlbnRCYWRnZSB9fQogICAgICAgIDwvZWwtdGFnPgogICAgICAgIDxkaXYgY2xhc3M9InNwYWNlciIgLz4KICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJWaWV3IiBAY2xpY2s9Im9wZW5QcmV2aWV3Ij7lnKjnur/pooTop4g8L2VsLWJ1dHRvbj4KICAgICAgICA8IS0tIOWPmOS9k+e8lui+keaooeW8j+S4i+makOiXj+OAjOWPkeW4g+OAjeaMiemSru+8jOmBv+WFjeivr+aKiuWPmOS9k+W/q+eFp+WPkeWIsOe6v+S4iiAtLT4KICAgICAgICA8ZWwtYnV0dG9uIHYtaWY9IiF2YXJpYW50RWRpdGluZyIgdHlwZT0ic3VjY2VzcyIgOmljb249IlVwbG9hZCIgOmxvYWRpbmc9InB1Ymxpc2hpbmciIEBjbGljaz0ib25QdWJsaXNoIj4KICAgICAgICAgIHt7IGFjdGl2ZVRhYiA9PT0gJ2xlZCcgPyAn5Y+R5biDIExFRCDlpKflsY8nIDogYWN0aXZlVGFiID09PSAnaDUnID8gJ+WPkeW4gyBINSDliLDnur/kuIonIDogJ+WPkeW4g+WIsOe6v+S4iicgfX0KICAgICAgICA8L2VsLWJ1dHRvbj4KICAgICAgPC9kaXY+CiAgICA8L2VsLWNhcmQ+CgogICAgPGVsLXRhYnMgdi1tb2RlbD0iYWN0aXZlVGFiIiBjbGFzcz0iZWRpdG9yLXRhYnMiPgogICAgICA8IS0tID09PT09IOS4u+mimO+8iOW3sumakOiXj++8jOWGhemDqOS7jeeUn+aViO+8m+imgeaBouWkjeaUuSB2LWlmPSJ0cnVlIu+8iT09PT09IC0tPgogICAgICA8ZWwtdGFiLXBhbmUgdi1pZj0iZmFsc2UiIGxhYmVsPSLkuLvpopjmoLflvI8iIG5hbWU9InRoZW1lIj4KICAgICAgICA8ZGl2IGNsYXNzPSJ0aGVtZS1ncmlkIj4KICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCI+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPjxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7lk4HniYzoibLlvak8L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICAgICAgPGVsLWZvcm0gbGFiZWwtd2lkdGg9IjEwMHB4IiBsYWJlbC1wb3NpdGlvbj0ibGVmdCI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5ZOB54mM5Li76ImyIj4KICAgICAgICAgICAgICAgIDxlbC1jb2xvci1waWNrZXIgdi1tb2RlbD0idGhlbWVGb3JtLmJyYW5kX2NvbG9yIiBzaG93LWFscGhhIGNvbG9yLWZvcm1hdD0iaGV4IiAvPgogICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiPnt7IHRoZW1lRm9ybS5icmFuZF9jb2xvciB9fTwvc3Bhbj4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLovoXliqnoibIiPgogICAgICAgICAgICAgICAgPGVsLWNvbG9yLXBpY2tlciB2LW1vZGVsPSJ0aGVtZUZvcm0uYWNjZW50X2NvbG9yIiBzaG93LWFscGhhIGNvbG9yLWZvcm1hdD0iaGV4IiAvPgogICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiPnt7IHRoZW1lRm9ybS5hY2NlbnRfY29sb3IgfX08L3NwYW4+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5paH5a2X5Li76ImyIj4KICAgICAgICAgICAgICAgIDxlbC1jb2xvci1waWNrZXIgdi1tb2RlbD0idGhlbWVGb3JtLnRleHRfY29sb3IiIHNob3ctYWxwaGEgY29sb3ItZm9ybWF0PSJoZXgiIC8+CiAgICAgICAgICAgICAgICA8c3BhbiBjbGFzcz0iaGludCI+e3sgdGhlbWVGb3JtLnRleHRfY29sb3IgfX08L3NwYW4+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgIDwvZWwtZm9ybT4KICAgICAgICAgIDwvZWwtY2FyZD4KCiAgICAgICAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iY2ZnLWNhcmQiPgogICAgICAgICAgICA8dGVtcGxhdGUgI2hlYWRlcj48c3BhbiBjbGFzcz0iY2FyZC10aXRsZSI+6IOM5pmvPC9zcGFuPjwvdGVtcGxhdGU+CiAgICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSIxMDBweCIgbGFiZWwtcG9zaXRpb249ImxlZnQiPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuiDjOaZr+exu+WeiyI+CiAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tZ3JvdXAgdi1tb2RlbD0idGhlbWVGb3JtLmJhY2tncm91bmRfdHlwZSI+CiAgICAgICAgICAgICAgICAgIDxlbC1yYWRpby1idXR0b24gdmFsdWU9ImNvbG9yIj7nuq/oibI8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiB2YWx1ZT0iZ3JhZGllbnQiPua4kOWPmDwvZWwtcmFkaW8tYnV0dG9uPgogICAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tYnV0dG9uIHZhbHVlPSJpbWFnZSI+5Zu+54mHPC9lbC1yYWRpby1idXR0b24+CiAgICAgICAgICAgICAgICA8L2VsLXJhZGlvLWdyb3VwPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0idGhlbWVGb3JtLmJhY2tncm91bmRfdHlwZSA9PT0gJ2NvbG9yJyIgbGFiZWw9IuiDjOaZr+iJsiI+CiAgICAgICAgICAgICAgICA8ZWwtY29sb3ItcGlja2VyIHYtbW9kZWw9InRoZW1lRm9ybS5iYWNrZ3JvdW5kX3ZhbHVlIiBzaG93LWFscGhhIGNvbG9yLWZvcm1hdD0iaGV4IiAvPgogICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiPnt7IHRoZW1lRm9ybS5iYWNrZ3JvdW5kX3ZhbHVlIH19PC9zcGFuPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0idGhlbWVGb3JtLmJhY2tncm91bmRfdHlwZSA9PT0gJ2dyYWRpZW50JyIgbGFiZWw9Iua4kOWPmCBDU1MiPgogICAgICAgICAgICAgICAgPGVsLWlucHV0CiAgICAgICAgICAgICAgICAgIHYtbW9kZWw9InRoZW1lRm9ybS5iYWNrZ3JvdW5kX3ZhbHVlIiB0eXBlPSJ0ZXh0YXJlYSIgOnJvd3M9IjIiCiAgICAgICAgICAgICAgICAgIHBsYWNlaG9sZGVyPSLlpoIgbGluZWFyLWdyYWRpZW50KDEzNWRlZywjMGEwYTBhLCMxYTFhMWEpIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0idGhlbWVGb3JtLmJhY2tncm91bmRfdHlwZSA9PT0gJ2ltYWdlJyIgbGFiZWw9IuiDjOaZr+WbviI+CiAgICAgICAgICAgICAgICA8ZWwtdXBsb2FkCiAgICAgICAgICAgICAgICAgIDpzaG93LWZpbGUtbGlzdD0iZmFsc2UiCiAgICAgICAgICAgICAgICAgIDpodHRwLXJlcXVlc3Q9IihvcHQpID0+IHVwbG9hZEZpbGUoJ2JhY2tncm91bmRfaW1hZ2UnLCBvcHQpIgogICAgICAgICAgICAgICAgICBhY2NlcHQ9ImltYWdlLyoiPgogICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJQaWN0dXJlIj7pgInmi6nlm77niYc8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgIDwvZWwtdXBsb2FkPgogICAgICAgICAgICAgICAgPGVsLWltYWdlCiAgICAgICAgICAgICAgICAgIHYtaWY9InRoZW1lPy5iYWNrZ3JvdW5kX2ltYWdlX3VybCIKICAgICAgICAgICAgICAgICAgOnNyYz0idGhlbWUuYmFja2dyb3VuZF9pbWFnZV91cmwiCiAgICAgICAgICAgICAgICAgIGZpdD0iY292ZXIiCiAgICAgICAgICAgICAgICAgIHN0eWxlPSJ3aWR0aDoxMjBweDtoZWlnaHQ6ODBweDtib3JkZXItcmFkaXVzOjZweDttYXJnaW4tbGVmdDoxMnB4IiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L2VsLWZvcm0+CiAgICAgICAgICA8L2VsLWNhcmQ+CgogICAgICAgICAgPGVsLWNhcmQgc2hhZG93PSJuZXZlciIgY2xhc3M9ImNmZy1jYXJkIj4KICAgICAgICAgICAgPHRlbXBsYXRlICNoZWFkZXI+PHNwYW4gY2xhc3M9ImNhcmQtdGl0bGUiPkxvZ28gLyBGYXZpY29uPC9zcGFuPjwvdGVtcGxhdGU+CiAgICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSIxMDBweCIgbGFiZWwtcG9zaXRpb249ImxlZnQiPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IkxvZ28iPgogICAgICAgICAgICAgICAgPGVsLXVwbG9hZAogICAgICAgICAgICAgICAgICA6c2hvdy1maWxlLWxpc3Q9ImZhbHNlIgogICAgICAgICAgICAgICAgICA6aHR0cC1yZXF1ZXN0PSIob3B0KSA9PiB1cGxvYWRGaWxlKCdsb2dvJywgb3B0KSIKICAgICAgICAgICAgICAgICAgYWNjZXB0PSJpbWFnZS9wbmcsaW1hZ2UvanBlZyxpbWFnZS9zdmcreG1sIj4KICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iUGljdHVyZSI+5LiK5LygIExvZ288L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgIDwvZWwtdXBsb2FkPgogICAgICAgICAgICAgICAgPGVsLWltYWdlCiAgICAgICAgICAgICAgICAgIHYtaWY9InRoZW1lPy5sb2dvX3VybCIKICAgICAgICAgICAgICAgICAgOnNyYz0idGhlbWUubG9nb191cmwiCiAgICAgICAgICAgICAgICAgIGZpdD0iY29udGFpbiIKICAgICAgICAgICAgICAgICAgc3R5bGU9ImhlaWdodDo0MHB4O21hcmdpbi1sZWZ0OjEycHg7YmFja2dyb3VuZDojMjIyO2JvcmRlci1yYWRpdXM6NHB4O3BhZGRpbmc6NHB4IiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IkZhdmljb24iPgogICAgICAgICAgICAgICAgPGVsLXVwbG9hZAogICAgICAgICAgICAgICAgICA6c2hvdy1maWxlLWxpc3Q9ImZhbHNlIgogICAgICAgICAgICAgICAgICA6aHR0cC1yZXF1ZXN0PSIob3B0KSA9PiB1cGxvYWRGaWxlKCdmYXZpY29uJywgb3B0KSIKICAgICAgICAgICAgICAgICAgYWNjZXB0PSJpbWFnZS9wbmcsaW1hZ2UveC1pY29uLGltYWdlL3N2Zyt4bWwiPgogICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJQaWN0dXJlIj7kuIrkvKAgRmF2aWNvbjwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgPC9lbC11cGxvYWQ+CiAgICAgICAgICAgICAgICA8ZWwtaW1hZ2UKICAgICAgICAgICAgICAgICAgdi1pZj0idGhlbWU/LmZhdmljb25fdXJsIgogICAgICAgICAgICAgICAgICA6c3JjPSJ0aGVtZS5mYXZpY29uX3VybCIKICAgICAgICAgICAgICAgICAgZml0PSJjb250YWluIgogICAgICAgICAgICAgICAgICBzdHlsZT0id2lkdGg6MzJweDtoZWlnaHQ6MzJweDttYXJnaW4tbGVmdDoxMnB4O2JhY2tncm91bmQ6IzIyMjtib3JkZXItcmFkaXVzOjRweDtwYWRkaW5nOjJweCIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPC9lbC1mb3JtPgogICAgICAgICAgPC9lbC1jYXJkPgoKICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCI+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPjxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7lrZfkvZM8L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICAgICAgPGVsLWZvcm0gbGFiZWwtd2lkdGg9IjEwMHB4IiBsYWJlbC1wb3NpdGlvbj0ibGVmdCI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5a2X5L2T5pePIj4KICAgICAgICAgICAgICAgIDxlbC1zZWxlY3Qgdi1tb2RlbD0idGhlbWVGb3JtLmZvbnRfZmFtaWx5IiBzdHlsZT0id2lkdGg6MTAwJSI+CiAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24KICAgICAgICAgICAgICAgICAgICB2LWZvcj0iZiBpbiBmb250UHJlc2V0cyIgOmtleT0iZi52YWx1ZSIKICAgICAgICAgICAgICAgICAgICA6bGFiZWw9ImYubGFiZWwiIDp2YWx1ZT0iZi52YWx1ZSIgLz4KICAgICAgICAgICAgICAgIDwvZWwtc2VsZWN0PgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuiHquWumuS5iSI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0idGhlbWVGb3JtLmZvbnRfZmFtaWx5IiBwbGFjZWhvbGRlcj0n5aaCICJOb3RvIFNhbnMgU0MiLCBzYW5zLXNlcmlmJyAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L2VsLWZvcm0+CiAgICAgICAgICA8L2VsLWNhcmQ+CgogICAgICAgICAgPCEtLSDlrp7ml7bpooTop4ggLS0+CiAgICAgICAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iY2ZnLWNhcmQgcHJldmlldy1jYXJkIiBzdHlsZT0iZ3JpZC1jb2x1bW46IDEgLyAtMSI+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPgogICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7lrp7ml7bpooTop4g8L3NwYW4+CiAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiPu+8iOS7heaYvuekuuS4u+mimOiJsuagt+W8j++8jOe8lui+keWQjuivt+eCueS/neWtmO+8iTwvc3Bhbj4KICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgICAgPGRpdiBjbGFzcz0icHJldmlldy1zdGFnZSIgOnN0eWxlPSJwcmV2aWV3QmdTdHlsZSI+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0icHJldmlldy1jYXJkLWlubmVyIiA6c3R5bGU9InsgZm9udEZhbWlseTogdGhlbWVGb3JtLmZvbnRfZmFtaWx5IH0iPgogICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0icGgtaDEiIDpzdHlsZT0ieyBjb2xvcjogdGhlbWVGb3JtLnRleHRfY29sb3IgfSI+5aGr5YaZ5L+h5oGvPC9kaXY+CiAgICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJwaC1zdWIiIDpzdHlsZT0ieyBjb2xvcjogdGhlbWVGb3JtLnRleHRfY29sb3IsIG9wYWNpdHk6IDAuNiB9Ij7ojrflj5bmgqjnmoTkuJPlsZ7lhZHmjaLnoIE8L2Rpdj4KICAgICAgICAgICAgICAgIDxkaXYgY2xhc3M9InBoLWJ0biIgOnN0eWxlPSJ7IGJhY2tncm91bmQ6IHRoZW1lRm9ybS5icmFuZF9jb2xvciB9Ij7nq4vljbPpooblj5Y8L2Rpdj4KICAgICAgICAgICAgICAgIDxkaXYgY2xhc3M9InBoLWNvZGUiIDpzdHlsZT0ieyBjb2xvcjogdGhlbWVGb3JtLmJyYW5kX2NvbG9yLCBib3JkZXJDb2xvcjogdGhlbWVGb3JtLmJyYW5kX2NvbG9yIH0iPgogICAgICAgICAgICAgICAgICAyIDkgNyAzIDYgMQogICAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgPC9lbC1jYXJkPgogICAgICAgIDwvZGl2PgoKICAgICAgICA8ZGl2IGNsYXNzPSJmb290ZXItYmFyIj4KICAgICAgICAgIDxlbC1idXR0b24gOmljb249IlJlZnJlc2hMZWZ0IiBAY2xpY2s9InJlc2V0VGhlbWUiPumHjee9rjwvZWwtYnV0dG9uPgogICAgICAgICAgPGVsLWJ1dHRvbiB0eXBlPSJwcmltYXJ5IiA6aWNvbj0iQ2hlY2siIDpsb2FkaW5nPSJzYXZpbmciIEBjbGljaz0ic2F2ZVRoZW1lIj7kv53lrZjkuLvpopg8L2VsLWJ1dHRvbj4KICAgICAgICA8L2Rpdj4KICAgICAgPC9lbC10YWItcGFuZT4KCiAgICAgIDwhLS0gPT09PT0gSDUg6JC95Zyw6aG177yI5Yy65Z2X5YyW77yJID09PT09IC0tPgogICAgICA8ZWwtdGFiLXBhbmUgbGFiZWw9Ikg1IOiQveWcsOmhtSIgbmFtZT0iaDUiPgogICAgICAgIDwhLS0gUGhhc2UgMi4077ya5Y+Y5L2T57yW6L6R5qih5byP5qiq5bmFIC0tPgogICAgICAgIDxlbC1hbGVydAogICAgICAgICAgdi1pZj0idmFyaWFudEVkaXRpbmciCiAgICAgICAgICB0eXBlPSJ3YXJuaW5nIiA6Y2xvc2FibGU9ImZhbHNlIiBzaG93LWljb24KICAgICAgICAgIHN0eWxlPSJtYXJnaW4tYm90dG9tOjE0cHgiCiAgICAgICAgICA6dGl0bGU9ImDkvaDmraPlnKjnvJbovpHlrp7pqozlj5jkvZPjgIwke3ZhcmlhbnRFZGl0aW5nLmtleX0gwrcgJHt2YXJpYW50RWRpdGluZy5uYW1lIHx8ICcnfeOAjSDigJQg5L+d5a2Y5Y+q5pu05paw6K+l5Y+Y5L2T5b+r54Wn77yM5LiN5b2x5ZON57q/5LiKIEg1YCIKICAgICAgICA+CiAgICAgICAgICA8dGVtcGxhdGUgI2RlZmF1bHQ+CiAgICAgICAgICAgIDxkaXYgc3R5bGU9ImRpc3BsYXk6ZmxleDsgYWxpZ24taXRlbXM6Y2VudGVyOyBnYXA6MTBweDsgbWFyZ2luLXRvcDo0cHg7Ij4KICAgICAgICAgICAgICA8c3BhbiBzdHlsZT0iY29sb3I6IHZhcigtLWVsLXRleHQtY29sb3ItcmVndWxhcik7IGZvbnQtc2l6ZTogMTNweDsiPgogICAgICAgICAgICAgICAg5Y+z5L6n6aKE6KeI5bCG5LuF5riy5p+T5q2k5Y+Y5L2T77yb6L+Q6JCl54K544CM5L+d5a2Y5Y+Y5L2T44CN5Lya5YaZ5YWl6K+l5Y+Y5L2T55qE5b+r54WnCiAgICAgICAgICAgICAgPC9zcGFuPgogICAgICAgICAgICAgIDxkaXYgc3R5bGU9ImZsZXg6MSIgLz4KICAgICAgICAgICAgICA8ZWwtYnV0dG9uIHNpemU9InNtYWxsIiBAY2xpY2s9ImV4aXRWYXJpYW50RWRpdGluZyI+6YCA5Ye65Y+Y5L2T57yW6L6RPC9lbC1idXR0b24+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLWFsZXJ0PgoKICAgICAgICA8ZGl2IGNsYXNzPSJoNS1sYXlvdXQiPgogICAgICAgICAgPCEtLSDlt6bvvJrnvJbovpHlmaggLS0+CiAgICAgICAgICA8ZGl2IGNsYXNzPSJoNS1lZGl0LWNvbCI+CiAgICAgICAgICAgIDxlbC10YWJzIHYtbW9kZWw9Img1UGFnZVRhYiIgY2xhc3M9Img1LXBhZ2UtdGFicyI+CiAgICAgICAgICAgICAgPCEtLSBQYWdlIDHvvJrlsZXnpLogLS0+CiAgICAgICAgICAgICAgPGVsLXRhYi1wYW5lIGxhYmVsPSJQYWdlIDEg5bGV56S6IiBuYW1lPSJwYWdlMSI+CiAgICAgICAgICAgICAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iY2ZnLWNhcmQiPgogICAgICAgICAgICAgICAgICA8dGVtcGxhdGUgI2hlYWRlcj48c3BhbiBjbGFzcz0iY2FyZC10aXRsZSI+6aG16Z2i6IOM5pmvPC9zcGFuPjwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSI4MHB4IiBsYWJlbC1wb3NpdGlvbj0ibGVmdCI+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i57G75Z6LIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1zZWxlY3Qgdi1tb2RlbD0iaDVGb3JtLnBhZ2UxX2JhY2tncm91bmQudHlwZSI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9Iue6r+iJsiIgdmFsdWU9ImNvbG9yIiAvPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlm77niYciIHZhbHVlPSJpbWFnZSIgLz4KICAgICAgICAgICAgICAgICAgICAgIDwvZWwtc2VsZWN0PgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0iaDVGb3JtLnBhZ2UxX2JhY2tncm91bmQudHlwZSA9PT0gJ2NvbG9yJyIgbGFiZWw9IuminOiJsuWAvCI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iaDVGb3JtLnBhZ2UxX2JhY2tncm91bmQudmFsdWUiIHBsYWNlaG9sZGVyPSIjMGEwYTBhIiAvPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWNvbG9yLXBpY2tlciB2LW1vZGVsPSJoNUZvcm0ucGFnZTFfYmFja2dyb3VuZC52YWx1ZSIgc2l6ZT0ic21hbGwiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiIC8+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSB2LWVsc2UgbGFiZWw9IuWbvueJhyI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtdXBsb2FkIDpzaG93LWZpbGUtbGlzdD0iZmFsc2UiIDpodHRwLXJlcXVlc3Q9IihvcHQpID0+IG9uVXBsb2FkQmxvY2tJbWFnZShvcHQsIGg1Rm9ybS5wYWdlMV9iYWNrZ3JvdW5kLCAndmFsdWUnKSIgYWNjZXB0PSJpbWFnZS8qIj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iUGljdHVyZSI+5LiK5Lyg6IOM5pmv5Zu+PC9lbC1idXR0b24+CiAgICAgICAgICAgICAgICAgICAgICA8L2VsLXVwbG9hZD4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gdi1pZj0iaDVGb3JtLnBhZ2UxX2JhY2tncm91bmQudmFsdWUiIDppY29uPSJEZWxldGUiIHR5cGU9ImRhbmdlciIgcGxhaW4gc2l6ZT0ic21hbGwiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiIEBjbGljaz0iaDVGb3JtLnBhZ2UxX2JhY2tncm91bmQgPSB7IHR5cGU6ICdjb2xvcicsIHZhbHVlOiAnIzBhMGEwYScsIGZpdDogJ2NvdmVyJyB9Ij7liKDpmaQ8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbWFnZSB2LWlmPSJoNUZvcm0ucGFnZTFfYmFja2dyb3VuZC52YWx1ZSIgOnNyYz0iaDVGb3JtLnBhZ2UxX2JhY2tncm91bmQudmFsdWUiIGZpdD0iY29udGFpbiIgc3R5bGU9IndpZHRoOjEyMHB4O2hlaWdodDo4MHB4O2JvcmRlci1yYWRpdXM6NnB4O21hcmdpbi1sZWZ0OjEycHg7YmFja2dyb3VuZDojMDAwIiAvPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0iaDVGb3JtLnBhZ2UxX2JhY2tncm91bmQudHlwZSA9PT0gJ2ltYWdlJyAmJiBoNUZvcm0ucGFnZTFfYmFja2dyb3VuZC52YWx1ZSIgbGFiZWw9IuWbvueJh+mAguW6lCI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tZ3JvdXAgdi1tb2RlbD0iaDVGb3JtLnBhZ2UxX2JhY2tncm91bmQuZml0Ij4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiB2YWx1ZT0iY292ZXIiPuWhq+WFheijgeWJqjwvZWwtcmFkaW8tYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tYnV0dG9uIHZhbHVlPSJjb250YWluIj7lrozmlbTmmL7npLo8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiB2YWx1ZT0iZmlsbCI+5ouJ5Ly46ZO65ruhPC9lbC1yYWRpby1idXR0b24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1yYWRpby1idXR0b24gdmFsdWU9InRvcCI+6aG26YOo5a+56b2QPC9lbC1yYWRpby1idXR0b24+CiAgICAgICAgICAgICAgICAgICAgICA8L2VsLXJhZGlvLWdyb3VwPgogICAgICAgICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaGludCIgc3R5bGU9Im1hcmdpbi10b3A6NnB4Ij4KICAgICAgICAgICAgICAgICAgICAgICAgPGI+5aGr5YWF6KOB5YmqPC9iPu+8muWbvueJh+Whq+a7oeWxj+W5le+8jOaMieavlOS+i+ijgeaOieS4pOerr++8iOacgOW4uOinge+8iTxicj4KICAgICAgICAgICAgICAgICAgICAgICAgPGI+5a6M5pW05pi+56S6PC9iPu+8muWbvueJh+WujOaVtOWPr+inge+8jOW3puWPsy/kuIrkuIvkvJrmnInnlZnnmb08YnI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxiPuaLieS8uOmTuua7oTwvYj7vvJrmi4nkvLjliLDpk7rmu6HlsY/luZXvvIzlj6/og73lj5jlvaI8YnI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxiPumhtumDqOWvuem9kDwvYj7vvJrlrr3luqbpk7rmu6HvvIzpobbpg6jlr7npvZDvvIzkuIvmlrnoo4HliIfvvIjpgILlkIjmqKrniYjlub/lkYrvvIkKICAgICAgICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICA8L2VsLWZvcm0+CiAgICAgICAgICAgICAgICA8L2VsLWNhcmQ+CiAgICAgICAgICAgICAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iY2ZnLWNhcmQiPgogICAgICAgICAgICAgICAgICA8dGVtcGxhdGUgI2hlYWRlcj48c3BhbiBjbGFzcz0iY2FyZC10aXRsZSI+6aG16Z2i5aS06YOoPC9zcGFuPjwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSI4MHB4IiBsYWJlbC1wb3NpdGlvbj0ibGVmdCI+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5qCH6aKYIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJoNUZvcm0uaGVhZGVyX3RpdGxlIiBtYXhsZW5ndGg9IjY0IiBzaG93LXdvcmQtbGltaXQgLz4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLlia/moIfpopgiPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9Img1Rm9ybS5oZWFkZXJfc3VidGl0bGUiIG1heGxlbmd0aD0iMTI4IiBzaG93LXdvcmQtbGltaXQgLz4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLkvY3nva4iPgogICAgICAgICAgICAgICAgICAgICAgPGRpdiBzdHlsZT0iZGlzcGxheTpmbGV4OyBnYXA6OHB4OyBhbGlnbi1pdGVtczpjZW50ZXI7Ij4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWlucHV0LW51bWJlciB2LW1vZGVsPSJoNUZvcm0uaGVhZGVyX3Bvc2l0aW9uLngiIDptaW49IjAiIDptYXg9IjEwMCIgOnByZWNpc2lvbj0iMSIgc2l6ZT0ic21hbGwiIHN0eWxlPSJ3aWR0aDo5MHB4IiAvPgogICAgICAgICAgICAgICAgICAgICAgICA8c3BhbiBjbGFzcz0iaGludCI+JSBYPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtaW5wdXQtbnVtYmVyIHYtbW9kZWw9Img1Rm9ybS5oZWFkZXJfcG9zaXRpb24ueSIgOm1pbj0iMCIgOm1heD0iMTAwIiA6cHJlY2lzaW9uPSIxIiBzaXplPSJzbWFsbCIgc3R5bGU9IndpZHRoOjkwcHgiIC8+CiAgICAgICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJoaW50Ij4lIFk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gc2l6ZT0ic21hbGwiIEBjbGljaz0iaDVGb3JtLmhlYWRlcl9wb3NpdGlvbiA9IHsgeDogNTAsIHk6IDEwIH0iPumHjee9rjwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJoaW50IiBzdHlsZT0ibWFyZ2luLXRvcDo0cHgiPlg9NTAsWT0xMCDooajnpLrmsLTlubPlsYXkuK3jgIHot53pobbpg6ggMTAlPC9kaXY+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybT4KICAgICAgICAgICAgICAgIDwvZWwtY2FyZD4KCiAgICAgICAgICAgICAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iY2ZnLWNhcmQiPgogICAgICAgICAgICAgICAgICA8dGVtcGxhdGUgI2hlYWRlcj48c3BhbiBjbGFzcz0iY2FyZC10aXRsZSI+6Lez6L2s5oyJ6ZKuPC9zcGFuPjwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSI4MHB4IiBsYWJlbC1wb3NpdGlvbj0ibGVmdCI+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5oyJ6ZKu5paH5a2XIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJoNUZvcm0ucGFnZTFfYnV0dG9uX3RleHQiIG1heGxlbmd0aD0iMzIiIHNob3ctd29yZC1saW1pdCBwbGFjZWhvbGRlcj0i5LiL5LiA5q2lIiAvPgogICAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiPueCueWHu+WQjui3s+i9rOWIsCBQYWdlIDLvvIjooajljZXpobXvvIk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5a2X5L2T5aSn5bCPIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJoNUZvcm0ucGFnZTFfYnV0dG9uX2ZvbnRfc2l6ZSIgcGxhY2Vob2xkZXI9IjE2cHgiIHN0eWxlPSJ3aWR0aDoxMDBweCIgLz4KICAgICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJoaW50IiBzdHlsZT0ibWFyZ2luLWxlZnQ6OHB4Ij7lpoIgMTZweCAvIDE4cHg8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5oyJ6ZKu5aSn5bCPIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJoNUZvcm0ucGFnZTFfYnV0dG9uX3BhZGRpbmciIHBsYWNlaG9sZGVyPSIxNHB4IiBzdHlsZT0id2lkdGg6MTAwcHgiIC8+CiAgICAgICAgICAgICAgICAgICAgICA8c3BhbiBjbGFzcz0iaGludCIgc3R5bGU9Im1hcmdpbi1sZWZ0OjhweCI+5YaF6L656Led77yM5aaCIDE0cHgg5oiWICIxOHB4IDI0cHgiPC9zcGFuPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWtl+S9k+minOiJsiI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtY29sb3ItcGlja2VyIHYtbW9kZWw9Img1Rm9ybS5wYWdlMV9idXR0b25fZm9udF9jb2xvciIgY29sb3ItZm9ybWF0PSJoZXgiIHNpemU9InNtYWxsIiAvPgogICAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiPnt7IGg1Rm9ybS5wYWdlMV9idXR0b25fZm9udF9jb2xvciB8fCAiI2ZmZmZmZiIgfX08L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5oyJ6ZKu6aKc6ImyIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1jb2xvci1waWNrZXIgdi1tb2RlbD0iaDVGb3JtLnBhZ2UxX2J1dHRvbl9iZ19jb2xvciIgY29sb3ItZm9ybWF0PSJoZXgiIHNpemU9InNtYWxsIiAvPgogICAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiPnt7IGg1Rm9ybS5wYWdlMV9idXR0b25fYmdfY29sb3IgfHwgIui3n+maj+WTgeeJjOiJsiIgfX08L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5L2N572uIj4KICAgICAgICAgICAgICAgICAgICAgIDxkaXYgc3R5bGU9ImRpc3BsYXk6ZmxleDsgZ2FwOjhweDsgYWxpZ24taXRlbXM6Y2VudGVyOyI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dC1udW1iZXIgdi1tb2RlbD0iaDVGb3JtLmJ1dHRvbl9wb3NpdGlvbi54IiA6bWluPSIwIiA6bWF4PSIxMDAiIDpwcmVjaXNpb249IjEiIHNpemU9InNtYWxsIiBzdHlsZT0id2lkdGg6OTBweCIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiPiUgWDwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWlucHV0LW51bWJlciB2LW1vZGVsPSJoNUZvcm0uYnV0dG9uX3Bvc2l0aW9uLnkiIDptaW49IjAiIDptYXg9IjEwMCIgOnByZWNpc2lvbj0iMSIgc2l6ZT0ic21hbGwiIHN0eWxlPSJ3aWR0aDo5MHB4IiAvPgogICAgICAgICAgICAgICAgICAgICAgICA8c3BhbiBjbGFzcz0iaGludCI+JSBZPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIHNpemU9InNtYWxsIiBAY2xpY2s9Img1Rm9ybS5idXR0b25fcG9zaXRpb24gPSB7IHg6IDUwLCB5OiA4MCB9Ij7ph43nva48L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaGludCIgc3R5bGU9Im1hcmdpbi10b3A6NHB4Ij5YPTUwLFk9ODAg6KGo56S65rC05bmz5bGF5Lit44CB6Led6aG26YOoIDgwJTwvZGl2PgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICA8L2VsLWZvcm0+CiAgICAgICAgICAgICAgICA8L2VsLWNhcmQ+CgogICAgICAgICAgICAgICAgPGVsLWNhcmQgc2hhZG93PSJuZXZlciIgY2xhc3M9ImNmZy1jYXJkIj4KICAgICAgICAgICAgICAgICAgPHRlbXBsYXRlICNoZWFkZXI+CiAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImNhcmQtdGl0bGUiPuWGheWuueWMuuWdlzwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICA8c3BhbiBjbGFzcz0iaGludCI+5YWxIHt7IGg1Rm9ybS5ibG9ja3MubGVuZ3RoIH19IOS4qjwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJoZHItc3BhY2VyIiAvPgogICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93biBAY29tbWFuZD0iYWRkQmxvY2siPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiB0eXBlPSJwcmltYXJ5IiBzaXplPSJzbWFsbCIgOmljb249IlBsdXMiPua3u+WKoOWMuuWdlzwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgPHRlbXBsYXRlICNkcm9wZG93bj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLW1lbnU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLWl0ZW0gY29tbWFuZD0iaW1hZ2UiPuWbvueJhzwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJ2aWRlbyI+6KeG6aKRPC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9InRleHQiPuaZrumAmuaWh+acrDwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJyaWNoX3RleHQiPuWvjOaWh+acrChIVE1MKTwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJkaXZpZGVyIj7liIblibLnur88L2VsLWRyb3Bkb3duLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLWl0ZW0gY29tbWFuZD0iY291bnRkb3duIj7lgJLorqHml7Y8L2VsLWRyb3Bkb3duLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZWwtZHJvcGRvd24tbWVudT4KICAgICAgICAgICAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1kcm9wZG93bj4KICAgICAgICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgPGVsLWVtcHR5IHYtaWY9IiFoNUZvcm0uYmxvY2tzLmxlbmd0aCIgZGVzY3JpcHRpb249IuaaguaXoOWMuuWdl++8jOeCueWPs+S4iuinkua3u+WKoCIgOmltYWdlLXNpemU9IjYwIiAvPgogICAgICAgICAgICAgICAgICA8ZGl2IHYtZWxzZSBjbGFzcz0iaXRlbS1saXN0Ij4KICAgICAgICAgICAgICAgICAgICA8ZGl2IHYtZm9yPSIoYiwgaSkgaW4gaDVGb3JtLmJsb2NrcyIgOmtleT0iYi5pZCIgY2xhc3M9Iml0ZW0tcm93IiBkcmFnZ2FibGU9InRydWUiIDpjbGFzcz0ieyAnaXMtZHJhZy1vdmVyJzogZHJhZ092ZXJJbmRleCA9PT0gJ2hiJyArIGkgfSIgQGRyYWdzdGFydD0iZHJhZ0Zyb21JbmRleCA9IGkiIEBkcmFnb3Zlci5wcmV2ZW50PSJkcmFnT3ZlckluZGV4ID0gJ2hiJyArIGkiIEBkcmFnbGVhdmU9ImRyYWdPdmVySW5kZXggPSAnJyIgQGRyb3A9Im1vdmVUbyhoNUZvcm0uYmxvY2tzLCBkcmFnRnJvbUluZGV4LCBpKTsgZHJhZ092ZXJJbmRleCA9ICcnIiBAZHJhZ2VuZD0iZHJhZ092ZXJJbmRleCA9ICcnIj4KICAgICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJkcmFnLWhhbmRsZSIgdGl0bGU9IuaLluaLveaOkuW6jyI+4qC/PC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaXRlbS1pbmZvIj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLXRhZyBzaXplPSJzbWFsbCI+e3sgYmxvY2tMYWJlbChiLnR5cGUpIH19PC9lbC10YWc+CiAgICAgICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJpdGVtLXN1bW1hcnkiPnt7IGJsb2NrU3VtbWFyeShiKSB9fTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaXRlbS1hY3Rpb25zIj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iQXJyb3dVcCIgOmRpc2FibGVkPSJpID09PSAwIiBAY2xpY2s9Im1vdmVCbG9jayhpLCAtMSkiIGNpcmNsZSBzaXplPSJzbWFsbCIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iQXJyb3dEb3duIiA6ZGlzYWJsZWQ9ImkgPT09IGg1Rm9ybS5ibG9ja3MubGVuZ3RoIC0gMSIgQGNsaWNrPSJtb3ZlQmxvY2soaSwgMSkiIGNpcmNsZSBzaXplPSJzbWFsbCIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iRWRpdCIgQGNsaWNrPSJlZGl0QmxvY2soaSkiIGNpcmNsZSBzaXplPSJzbWFsbCIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iRGVsZXRlIiB0eXBlPSJkYW5nZXIiIHBsYWluIEBjbGljaz0icmVtb3ZlQmxvY2soaSkiIGNpcmNsZSBzaXplPSJzbWFsbCIgLz4KICAgICAgICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICAgIDwvZWwtY2FyZD4KICAgICAgICAgICAgICA8L2VsLXRhYi1wYW5lPgoKICAgICAgICAgICAgICA8IS0tIFBhZ2UgMu+8muihqOWNlSAtLT4KICAgICAgICAgICAgICA8ZWwtdGFiLXBhbmUgbGFiZWw9IlBhZ2UgMiDooajljZUiIG5hbWU9InBhZ2UyIj4KICAgICAgICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCI+CiAgICAgICAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPjxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7pobXpnaLog4zmma88L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgPGVsLWZvcm0gbGFiZWwtd2lkdGg9IjgwcHgiIGxhYmVsLXBvc2l0aW9uPSJsZWZ0Ij4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLnsbvlnosiPgogICAgICAgICAgICAgICAgICAgICAgPGVsLXNlbGVjdCB2LW1vZGVsPSJoNUZvcm0ucGFnZTJfYmFja2dyb3VuZC50eXBlIj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i57qv6ImyIiB2YWx1ZT0iY29sb3IiIC8+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuWbvueJhyIgdmFsdWU9ImltYWdlIiAvPgogICAgICAgICAgICAgICAgICAgICAgPC9lbC1zZWxlY3Q+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSB2LWlmPSJoNUZvcm0ucGFnZTJfYmFja2dyb3VuZC50eXBlID09PSAnY29sb3InIiBsYWJlbD0i6aKc6Imy5YC8Ij4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJoNUZvcm0ucGFnZTJfYmFja2dyb3VuZC52YWx1ZSIgcGxhY2Vob2xkZXI9IiMwYTBhMGEiIC8+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtY29sb3ItcGlja2VyIHYtbW9kZWw9Img1Rm9ybS5wYWdlMl9iYWNrZ3JvdW5kLnZhbHVlIiBzaXplPSJzbWFsbCIgc3R5bGU9Im1hcmdpbi1sZWZ0OjhweCIgLz4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIHYtZWxzZSBsYWJlbD0i5Zu+54mHIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC11cGxvYWQgOnNob3ctZmlsZS1saXN0PSJmYWxzZSIgOmh0dHAtcmVxdWVzdD0iKG9wdCkgPT4gb25VcGxvYWRCbG9ja0ltYWdlKG9wdCwgaDVGb3JtLnBhZ2UyX2JhY2tncm91bmQsICd2YWx1ZScpIiBhY2NlcHQ9ImltYWdlLyoiPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJQaWN0dXJlIj7kuIrkvKDog4zmma/lm748L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgIDwvZWwtdXBsb2FkPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiB2LWlmPSJoNUZvcm0ucGFnZTJfYmFja2dyb3VuZC52YWx1ZSIgOmljb249IkRlbGV0ZSIgdHlwZT0iZGFuZ2VyIiBwbGFpbiBzaXplPSJzbWFsbCIgc3R5bGU9Im1hcmdpbi1sZWZ0OjhweCIgQGNsaWNrPSJoNUZvcm0ucGFnZTJfYmFja2dyb3VuZCA9IHsgdHlwZTogJ2NvbG9yJywgdmFsdWU6ICcjMGEwYTBhJywgZml0OiAnY292ZXInIH0iPuWIoOmZpDwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWltYWdlIHYtaWY9Img1Rm9ybS5wYWdlMl9iYWNrZ3JvdW5kLnZhbHVlIiA6c3JjPSJoNUZvcm0ucGFnZTJfYmFja2dyb3VuZC52YWx1ZSIgZml0PSJjb250YWluIiBzdHlsZT0id2lkdGg6MTIwcHg7aGVpZ2h0OjgwcHg7Ym9yZGVyLXJhZGl1czo2cHg7bWFyZ2luLWxlZnQ6MTJweDtiYWNrZ3JvdW5kOiMwMDAiIC8+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSB2LWlmPSJoNUZvcm0ucGFnZTJfYmFja2dyb3VuZC50eXBlID09PSAnaW1hZ2UnICYmIGg1Rm9ybS5wYWdlMl9iYWNrZ3JvdW5kLnZhbHVlIiBsYWJlbD0i5Zu+54mH6YCC5bqUIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1yYWRpby1ncm91cCB2LW1vZGVsPSJoNUZvcm0ucGFnZTJfYmFja2dyb3VuZC5maXQiPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tYnV0dG9uIHZhbHVlPSJjb3ZlciI+5aGr5YWF6KOB5YmqPC9lbC1yYWRpby1idXR0b24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1yYWRpby1idXR0b24gdmFsdWU9ImNvbnRhaW4iPuWujOaVtOaYvuekujwvZWwtcmFkaW8tYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tYnV0dG9uIHZhbHVlPSJmaWxsIj7mi4nkvLjpk7rmu6E8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiB2YWx1ZT0idG9wIj7pobbpg6jlr7npvZA8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgIDwvZWwtcmFkaW8tZ3JvdXA+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybT4KICAgICAgICAgICAgICAgIDwvZWwtY2FyZD4KICAgICAgICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCI+CiAgICAgICAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPgogICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7ooajljZXlrZfmrrU8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiPuWFsSB7eyBoNUZvcm0uZm9ybV9maWVsZHMubGVuZ3RoIH19IOS4qjwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJoZHItc3BhY2VyIiAvPgogICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93biBAY29tbWFuZD0iYWRkRmllbGQiPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiB0eXBlPSJwcmltYXJ5IiBzaXplPSJzbWFsbCIgOmljb249IlBsdXMiPua3u+WKoOWtl+autTwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgPHRlbXBsYXRlICNkcm9wZG93bj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLW1lbnU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLWl0ZW0gY29tbWFuZD0idGV4dCI+5paH5pysPC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9Im5hbWUiPuWnk+WQjTwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJhZ2UiPuW5tOm+hDwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJ0ZWwiPuaJi+acuuWPtzwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJyYWRpbyI+5Y2V6YCJPC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9ImdlbmRlciI+5oCn5YirPC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9InNlbGVjdCI+5LiL5ouJPC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9ImNoZWNrYm94Ij7li77pgIk8L2VsLWRyb3Bkb3duLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLWl0ZW0gY29tbWFuZD0ibXVsdGlzZWxlY3QiPuWkmumAiTwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9lbC1kcm9wZG93bi1tZW51PgogICAgICAgICAgICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgICA8L2VsLWRyb3Bkb3duPgogICAgICAgICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICAgICAgICA8ZWwtZW1wdHkgdi1pZj0iIWg1Rm9ybS5mb3JtX2ZpZWxkcy5sZW5ndGgiIGRlc2NyaXB0aW9uPSLmmoLml6DlrZfmrrUiIDppbWFnZS1zaXplPSI2MCIgLz4KICAgICAgICAgICAgICAgICAgPGRpdiB2LWVsc2UgY2xhc3M9Iml0ZW0tbGlzdCI+CiAgICAgICAgICAgICAgICAgICAgPGRpdiB2LWZvcj0iKGYsIGkpIGluIGg1Rm9ybS5mb3JtX2ZpZWxkcyIgOmtleT0iZi5rZXkiIGNsYXNzPSJpdGVtLXJvdyIgZHJhZ2dhYmxlPSJ0cnVlIiA6Y2xhc3M9InsgJ2lzLWRyYWctb3Zlcic6IGRyYWdPdmVySW5kZXggPT09ICdoZicgKyBpIH0iIEBkcmFnc3RhcnQ9ImRyYWdGcm9tSW5kZXggPSBpIiBAZHJhZ292ZXIucHJldmVudD0iZHJhZ092ZXJJbmRleCA9ICdoZicgKyBpIiBAZHJhZ2xlYXZlPSJkcmFnT3ZlckluZGV4ID0gJyciIEBkcm9wPSJtb3ZlVG8oaDVGb3JtLmZvcm1fZmllbGRzLCBkcmFnRnJvbUluZGV4LCBpKTsgZHJhZ092ZXJJbmRleCA9ICcnIiBAZHJhZ2VuZD0iZHJhZ092ZXJJbmRleCA9ICcnIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC10YWcgc2l6ZT0ic21hbGwiIDp0eXBlPSJmLnJlcXVpcmVkID8gJ2RhbmdlcicgOiAnaW5mbyciPnt7IGYubGFiZWwgfHwgZi5rZXkgfX08L2VsLXRhZz4KICAgICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJpdGVtLXN1bW1hcnkiPnt7IGZpZWxkTGFiZWwoZi50eXBlKSB9fTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIDxkaXYgY2xhc3M9Iml0ZW0tYWN0aW9ucyI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24tZ3JvdXAgc2l6ZT0ic21hbGwiPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gOmljb249IkFycm93VXAiIDpkaXNhYmxlZD0iaSA9PT0gMCIgQGNsaWNrPSJtb3ZlRmllbGQoaSwgLTEpIiAvPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gOmljb249IkFycm93RG93biIgOmRpc2FibGVkPSJpID09PSBoNUZvcm0uZm9ybV9maWVsZHMubGVuZ3RoIC0gMSIgQGNsaWNrPSJtb3ZlRmllbGQoaSwgMSkiIC8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iRWRpdCIgQGNsaWNrPSJlZGl0RmllbGQoaSkiIC8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iRGVsZXRlIiB0eXBlPSJkYW5nZXIiIHBsYWluIEBjbGljaz0icmVtb3ZlRmllbGQoaSkiIC8+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZWwtYnV0dG9uLWdyb3VwPgogICAgICAgICAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgICA8ZWwtZm9ybSBsYWJlbC13aWR0aD0iODBweCIgbGFiZWwtcG9zaXRpb249ImxlZnQiIHN0eWxlPSJtYXJnaW4tdG9wOjE0cHgiPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IumikeaOpyI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtc2VsZWN0IHYtbW9kZWw9Img1Rm9ybS5yYXRlX2xpbWl0IiBzdHlsZT0id2lkdGg6MTAwJSI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuaXoOmZkOWItiIgdmFsdWU9Im5vbmUiIC8+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9Iuavj+iuvuWkh+avj+WkqSAxIOasoSIgdmFsdWU9InBlcl9kZXZpY2VfZGF5IiAvPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLmr4/miYvmnLrlj7fmr4/lpKkgMSDmrKEiIHZhbHVlPSJwZXJfcGhvbmVfZGF5IiAvPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLmr4/lvq7kv6HnlKjmiLfmr4/lpKkgMSDmrKEiIHZhbHVlPSJwZXJfb3BlbmlkX2RheSIgLz4KICAgICAgICAgICAgICAgICAgICAgIDwvZWwtc2VsZWN0PgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICA8L2VsLWZvcm0+CiAgICAgICAgICAgICAgICA8L2VsLWNhcmQ+CgogICAgICAgICAgICAgICAgPGVsLWNhcmQgc2hhZG93PSJuZXZlciIgY2xhc3M9ImNmZy1jYXJkIj4KICAgICAgICAgICAgICAgICAgPHRlbXBsYXRlICNoZWFkZXI+PHNwYW4gY2xhc3M9ImNhcmQtdGl0bGUiPumakOengeWNj+iurjwvc3Bhbj48L3RlbXBsYXRlPgogICAgICAgICAgICAgICAgICA8ZWwtZm9ybSBsYWJlbC13aWR0aD0iODBweCIgbGFiZWwtcG9zaXRpb249ImxlZnQiPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWQr+eUqCI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtc3dpdGNoIHYtbW9kZWw9Img1Rm9ybS5wcml2YWN5LmVuYWJsZWQiIC8+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSB2LWlmPSJoNUZvcm0ucHJpdmFjeS5lbmFibGVkICE9PSBmYWxzZSIgbGFiZWw9IuaWh+ahiCI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iaDVGb3JtLnByaXZhY3kudGV4dCIgcGxhY2Vob2xkZXI9IuaIkeW3sumYheivu+W5tuWQjOaEj+OAiuWuouaIt+makOengeWNj+iuruOAiyIgLz4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIHYtaWY9Img1Rm9ybS5wcml2YWN5LmVuYWJsZWQgIT09IGZhbHNlIiBsYWJlbD0i5Y2P6K6u6ZO+5o6lIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJoNUZvcm0ucHJpdmFjeS51cmwiIHBsYWNlaG9sZGVyPSJodHRwczovLy4uLu+8iOWPr+mAie+8iSIgLz4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtPgogICAgICAgICAgICAgICAgPC9lbC1jYXJkPgoKICAgICAgICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCI+CiAgICAgICAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPjxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7mj5DkuqTmjInpkq48L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgPGVsLWZvcm0gbGFiZWwtd2lkdGg9IjgwcHgiIGxhYmVsLXBvc2l0aW9uPSJsZWZ0Ij4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLmjInpkq7mlofmoYgiPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9Img1Rm9ybS5zdWJtaXRfYnV0dG9uLnRleHQiIHBsYWNlaG9sZGVyPSLnq4vljbPpooblj5YiIC8+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5oyJ6ZKu6aKc6ImyIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1jb2xvci1waWNrZXIgdi1tb2RlbD0iaDVGb3JtLnN1Ym1pdF9idXR0b24uY29sb3IiIGNvbG9yLWZvcm1hdD0iaGV4IiAvPgogICAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiPnt7IGg1Rm9ybS5zdWJtaXRfYnV0dG9uLmNvbG9yIHx8ICfot5/pmo/lk4HniYzoibInIH19PC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiB2LWlmPSJoNUZvcm0uc3VibWl0X2J1dHRvbi5jb2xvciIgbGluayB0eXBlPSJwcmltYXJ5IiBzaXplPSJzbWFsbCIgQGNsaWNrPSJoNUZvcm0uc3VibWl0X2J1dHRvbi5jb2xvciA9ICcnIj7kvb/nlKjlk4HniYzoibI8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtPgogICAgICAgICAgICAgICAgPC9lbC1jYXJkPgoKICAgICAgICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCI+CiAgICAgICAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPjxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7ot7PovazmjInpkq48L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgPGVsLWZvcm0gbGFiZWwtd2lkdGg9IjgwcHgiIGxhYmVsLXBvc2l0aW9uPSJsZWZ0Ij4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLmjInpkq7mloflrZciPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9Img1Rm9ybS5wYWdlMl9idXR0b25fdGV4dCIgbWF4bGVuZ3RoPSIzMiIgc2hvdy13b3JkLWxpbWl0IHBsYWNlaG9sZGVyPSLnq4vljbPpooblj5YiIC8+CiAgICAgICAgICAgICAgICAgICAgICA8c3BhbiBjbGFzcz0iaGludCIgc3R5bGU9Im1hcmdpbi1sZWZ0OjhweCI+54K55Ye75ZCO5o+Q5Lqk6KGo5Y2V5bm26Lez6L2s5YiwIFBhZ2UgM++8iOe7k+aenOmhte+8iTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtPgogICAgICAgICAgICAgICAgPC9lbC1jYXJkPgogICAgICAgICAgICAgIDwvZWwtdGFiLXBhbmU+CgogICAgICAgICAgICAgIDwhLS0gUGFnZSAz77ya57uT5p6cIC0tPgogICAgICAgICAgICAgIDxlbC10YWItcGFuZSBsYWJlbD0iUGFnZSAzIOe7k+aenCIgbmFtZT0icGFnZTMiPgogICAgICAgICAgICAgICAgPGVsLWNhcmQgc2hhZG93PSJuZXZlciIgY2xhc3M9ImNmZy1jYXJkIj4KICAgICAgICAgICAgICAgICAgPHRlbXBsYXRlICNoZWFkZXI+PHNwYW4gY2xhc3M9ImNhcmQtdGl0bGUiPumhtemdouiDjOaZrzwvc3Bhbj48L3RlbXBsYXRlPgogICAgICAgICAgICAgICAgICA8ZWwtZm9ybSBsYWJlbC13aWR0aD0iODBweCIgbGFiZWwtcG9zaXRpb249ImxlZnQiPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9Iuexu+WeiyI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtc2VsZWN0IHYtbW9kZWw9Img1Rm9ybS5wYWdlM19iYWNrZ3JvdW5kLnR5cGUiPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLnuq/oibIiIHZhbHVlPSJjb2xvciIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5Zu+54mHIiB2YWx1ZT0iaW1hZ2UiIC8+CiAgICAgICAgICAgICAgICAgICAgICA8L2VsLXNlbGVjdD4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIHYtaWY9Img1Rm9ybS5wYWdlM19iYWNrZ3JvdW5kLnR5cGUgPT09ICdjb2xvciciIGxhYmVsPSLpopzoibLlgLwiPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9Img1Rm9ybS5wYWdlM19iYWNrZ3JvdW5kLnZhbHVlIiBwbGFjZWhvbGRlcj0iIzBhMGEwYSIgLz4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1jb2xvci1waWNrZXIgdi1tb2RlbD0iaDVGb3JtLnBhZ2UzX2JhY2tncm91bmQudmFsdWUiIHNpemU9InNtYWxsIiBzdHlsZT0ibWFyZ2luLWxlZnQ6OHB4IiAvPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1lbHNlIGxhYmVsPSLlm77niYciPgogICAgICAgICAgICAgICAgICAgICAgPGVsLXVwbG9hZCA6c2hvdy1maWxlLWxpc3Q9ImZhbHNlIiA6aHR0cC1yZXF1ZXN0PSIob3B0KSA9PiBvblVwbG9hZEJsb2NrSW1hZ2Uob3B0LCBoNUZvcm0ucGFnZTNfYmFja2dyb3VuZCwgJ3ZhbHVlJykiIGFjY2VwdD0iaW1hZ2UvKiI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gOmljb249IlBpY3R1cmUiPuS4iuS8oOiDjOaZr+WbvjwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgPC9lbC11cGxvYWQ+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIHYtaWY9Img1Rm9ybS5wYWdlM19iYWNrZ3JvdW5kLnZhbHVlIiA6aWNvbj0iRGVsZXRlIiB0eXBlPSJkYW5nZXIiIHBsYWluIHNpemU9InNtYWxsIiBzdHlsZT0ibWFyZ2luLWxlZnQ6OHB4IiBAY2xpY2s9Img1Rm9ybS5wYWdlM19iYWNrZ3JvdW5kID0geyB0eXBlOiAnY29sb3InLCB2YWx1ZTogJyMwYTBhMGEnIH0iPuWIoOmZpDwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWltYWdlIHYtaWY9Img1Rm9ybS5wYWdlM19iYWNrZ3JvdW5kLnZhbHVlIiA6c3JjPSJoNUZvcm0ucGFnZTNfYmFja2dyb3VuZC52YWx1ZSIgZml0PSJjb3ZlciIgc3R5bGU9IndpZHRoOjEyMHB4O2hlaWdodDo4MHB4O2JvcmRlci1yYWRpdXM6NnB4O21hcmdpbi1sZWZ0OjEycHgiIC8+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybT4KICAgICAgICAgICAgICAgIDwvZWwtY2FyZD4KICAgICAgICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCI+CiAgICAgICAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPjxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7miJDlip/op4blm748L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgPGVsLWZvcm0gbGFiZWwtd2lkdGg9IjgwcHgiIGxhYmVsLXBvc2l0aW9uPSJsZWZ0Ij4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLlvLnnqpfmoIfpopgiPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9Img1Rm9ybS5zdWNjZXNzX3ZpZXcudGl0bGUiIHBsYWNlaG9sZGVyPSLmgqjku4rml6Xlt7Lpooblj5bov4ciIC8+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5Ymv5qCH6aKYIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJoNUZvcm0uc3VjY2Vzc192aWV3LnN1YnRpdGxlIiBwbGFjZWhvbGRlcj0i5q+P5Liq6K6+5aSH5q+P5aSp5Y+q6IO96aKG5Y+W5LiA5qyhIiAvPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9Iueggeagh+etviI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iaDVGb3JtLnN1Y2Nlc3Nfdmlldy5jb2RlX2xhYmVsIiBwbGFjZWhvbGRlcj0i5oKo55qE5YWR5o2i56CBIiAvPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuW6lemDqOaPkOekuiI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iaDVGb3JtLnN1Y2Nlc3Nfdmlldy5mb290ZXJfdGlwIiBwbGFjZWhvbGRlcj0i6K+35Zyo57uI56uv6aG16Z2i6L6T5YWl5q2k56CB6L+b6KGM5qC46ZSAIiAvPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICA8L2VsLWZvcm0+CiAgICAgICAgICAgICAgICA8L2VsLWNhcmQ+CiAgICAgICAgICAgICAgPC9lbC10YWItcGFuZT4KICAgICAgICAgICAgPC9lbC10YWJzPgoKICAgICAgICAgICAgPGRpdiBjbGFzcz0iZm9vdGVyLWJhciI+CiAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iUmVmcmVzaExlZnQiIEBjbGljaz0icmVzZXRINSI+e3sgdmFyaWFudEVkaXRpbmcgPyAn5oGi5aSN5Y+Y5L2T5Y6f5YC8JyA6ICfph43nva4nIH19PC9lbC1idXR0b24+CiAgICAgICAgICAgICAgPGVsLWJ1dHRvbiB0eXBlPSJwcmltYXJ5IiA6aWNvbj0iQ2hlY2siIDpsb2FkaW5nPSJzYXZpbmciIEBjbGljaz0ic2F2ZUg1Ij4KICAgICAgICAgICAgICAgIHt7IHZhcmlhbnRFZGl0aW5nID8gYOS/neWtmOWPmOS9kyAke3ZhcmlhbnRFZGl0aW5nLmtleX1gIDogJ+S/neWtmOiNieeovycgfX0KICAgICAgICAgICAgICA8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICA8L2Rpdj4KCiAgICAgICAgICA8IS0tIOWPs++8mmlmcmFtZSDpooTop4ggLS0+CiAgICAgICAgICA8ZGl2IGNsYXNzPSJoNS1wcmV2aWV3LWNvbCI+CiAgICAgICAgICAgIDxkaXYgY2xhc3M9InByZXZpZXctZnJhbWUtd3JhcCIgOmNsYXNzPSJ7ICdpcy1mdWxsc2NyZWVuJzogaDVQcmV2aWV3RnVsbCB9Ij4KICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJwcmV2aWV3LXRvb2xiYXIiPgogICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImNhcmQtdGl0bGUiPumihOiniDwvc3Bhbj4KICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJoaW50Ij57eyBoNVN0YXR1cyA9PT0gJ3B1Ymxpc2hlZCcgPyBg57q/5LiKIHYke2g1Py5jdXJyZW50X3ZlcnNpb259YCA6ICfojYnnqL8nIH19PC9zcGFuPgogICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaGRyLXNwYWNlciIgLz4KICAgICAgICAgICAgICAgIDxlbC1yYWRpby1ncm91cCB2LW1vZGVsPSJoNVByZXZpZXdNb2RlIiBzaXplPSJzbWFsbCI+CiAgICAgICAgICAgICAgICAgIDxlbC1yYWRpby1idXR0b24gdmFsdWU9InBob25lIj7miYvmnLrmoYY8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiB2YWx1ZT0iZnVsbCI+5aSn5bC65a+4PC9lbC1yYWRpby1idXR0b24+CiAgICAgICAgICAgICAgICA8L2VsLXJhZGlvLWdyb3VwPgogICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiBzaXplPSJzbWFsbCIgOmljb249IkZ1bGxTY3JlZW4iIEBjbGljaz0iaDVQcmV2aWV3RnVsbCA9ICFoNVByZXZpZXdGdWxsIiA6dGl0bGU9Img1UHJldmlld0Z1bGwgPyAn6YCA5Ye65YWo5bGPJyA6ICflhajlsY8nIj4KICAgICAgICAgICAgICAgICAge3sgaDVQcmV2aWV3RnVsbCA/ICfpgIDlh7onIDogJ+WFqOWxjycgfX0KICAgICAgICAgICAgICAgIDwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiBzaXplPSJzbWFsbCIgOmljb249IlJlZnJlc2giIEBjbGljaz0icmVmcmVzaFByZXZpZXciPuWIt+aWsDwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiBzaXplPSJzbWFsbCIgOmljb249IlZpZXciIEBjbGljaz0ib3BlblByZXZpZXciPuaWsOeql+WPozwvZWwtYnV0dG9uPgogICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgIDxkaXYgOmNsYXNzPSJbJ3ByZXZpZXctc3RhZ2UtaDUnLCAnbW9kZS0nICsgaDVQcmV2aWV3TW9kZV0iPgogICAgICAgICAgICAgICAgPGRpdiA6Y2xhc3M9IlsncGhvbmUtZnJhbWUnLCAnbW9kZS0nICsgaDVQcmV2aWV3TW9kZV0iPgogICAgICAgICAgICAgICAgICA8aWZyYW1lIHJlZj0icHJldmlld0lmcmFtZSIgOnNyYz0icHJldmlld1VybCIgY2xhc3M9InBob25lLWlmcmFtZSIgLz4KICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9InByZXZpZXctaGludCIgdi1pZj0iIWg1UHJldmlld0Z1bGwiPgogICAgICAgICAgICAgICAgPGVsLWljb24+PEluZm9GaWxsZWQgLz48L2VsLWljb24+CiAgICAgICAgICAgICAgICDkv53lrZjojYnnqL/lkI7ngrnliLfmlrDlj6/pooTop4jjgILnur/kuIrku43mmK/lt7Llj5HluIPniYjmnKzjgIIKICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICA8L2Rpdj4KICAgICAgICA8L2Rpdj4KCiAgICAgICAgPCEtLSDljLrlnZfnvJbovpHlmaggZGlhbG9nIC0tPgogICAgICAgIDxlbC1kaWFsb2cgdi1tb2RlbD0iYmxvY2tEbGdWaXNpYmxlIiA6dGl0bGU9ImDnvJbovpHljLrlnZfvvJoke2Jsb2NrTGFiZWwoZWRpdGluZ0Jsb2NrLnR5cGUpfWAiIHdpZHRoPSI1NDBweCIgZGVzdHJveS1vbi1jbG9zZT4KICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSIxMDBweCIgbGFiZWwtcG9zaXRpb249ImxlZnQiPgogICAgICAgICAgICA8IS0tIOmhtemdouWktOmDqCAtLT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImVkaXRpbmdCbG9jay50eXBlID09PSAnaGVhZGVyJyI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5qCH6aKYIj4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nQmxvY2sucHJvcHMudGl0bGUiIG1heGxlbmd0aD0iNjQiIHNob3ctd29yZC1saW1pdCAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWJr+agh+mimCI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLnN1YnRpdGxlIiBtYXhsZW5ndGg9IjEyOCIgc2hvdy13b3JkLWxpbWl0IC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICAgIDwhLS0g5Zu+54mHIC0tPgogICAgICAgICAgICA8dGVtcGxhdGUgdi1pZj0iZWRpdGluZ0Jsb2NrLnR5cGUgPT09ICdpbWFnZSciPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWbvueJhyI+CiAgICAgICAgICAgICAgICA8ZWwtdXBsb2FkIDpzaG93LWZpbGUtbGlzdD0iZmFsc2UiIDpodHRwLXJlcXVlc3Q9IihvcHQpID0+IG9uVXBsb2FkQmxvY2tJbWFnZShvcHQsIGVkaXRpbmdCbG9jay5wcm9wcykiIGFjY2VwdD0iaW1hZ2UvKiI+CiAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gOmljb249IlBpY3R1cmUiPuS4iuS8oOWbvueJhzwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgPC9lbC11cGxvYWQ+CiAgICAgICAgICAgICAgICA8ZWwtaW1hZ2Ugdi1pZj0iZWRpdGluZ0Jsb2NrLnByb3BzLnVybCIgOnNyYz0iZWRpdGluZ0Jsb2NrLnByb3BzLnVybCIgZml0PSJjb3ZlciIgc3R5bGU9IndpZHRoOjEyMHB4O2hlaWdodDo4MHB4O2JvcmRlci1yYWRpdXM6NnB4O21hcmdpbi1sZWZ0OjEycHgiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5pu/5Luj5paH5a2XIj4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nQmxvY2sucHJvcHMuYWx0IiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWvuem9kCI+CiAgICAgICAgICAgICAgICA8ZWwtc2VsZWN0IHYtbW9kZWw9ImVkaXRpbmdCbG9jay5wcm9wcy5hbGlnbiI+CiAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuWxheS4rSIgdmFsdWU9ImNlbnRlciIgLz4KICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5bem5a+56b2QIiB2YWx1ZT0ibGVmdCIgLz4KICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5Y+z5a+56b2QIiB2YWx1ZT0icmlnaHQiIC8+CiAgICAgICAgICAgICAgICA8L2VsLXNlbGVjdD4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgICAgPCEtLSDop4bpopEgLS0+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSB2LWlmPSJlZGl0aW5nQmxvY2sudHlwZSA9PT0gJ3ZpZGVvJyI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i6KeG6aKRIFVSTCI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLnVybCIgcGxhY2Vob2xkZXI9Ii5tcDQgLyAud2VibSIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLoh6rliqjmkq3mlL4iPgogICAgICAgICAgICAgICAgPGVsLXN3aXRjaCB2LW1vZGVsPSJlZGl0aW5nQmxvY2sucHJvcHMuYXV0b3BsYXkiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5b6q546vIj4KICAgICAgICAgICAgICAgIDxlbC1zd2l0Y2ggdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLmxvb3AiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5a+56b2QIj4KICAgICAgICAgICAgICAgIDxlbC1zZWxlY3Qgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLmFsaWduIj4KICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5bGF5LitIiB2YWx1ZT0iY2VudGVyIiAvPgogICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlt6blr7npvZAiIHZhbHVlPSJsZWZ0IiAvPgogICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlj7Plr7npvZAiIHZhbHVlPSJyaWdodCIgLz4KICAgICAgICAgICAgICAgIDwvZWwtc2VsZWN0PgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8IS0tIOaWh+acrCAtLT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImVkaXRpbmdCbG9jay50eXBlID09PSAndGV4dCciPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWGheWuuSI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLmNvbnRlbnQiIHR5cGU9InRleHRhcmVhIiA6cm93cz0iNCIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLlrZflj7ciPgogICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9ImVkaXRpbmdCbG9jay5wcm9wcy5mb250X3NpemUiIHBsYWNlaG9sZGVyPSLlpoIgMTVweCIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLpopzoibIiPgogICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9ImVkaXRpbmdCbG9jay5wcm9wcy5jb2xvciIgcGxhY2Vob2xkZXI9IiNmZmZmZmYiIC8+CiAgICAgICAgICAgICAgICA8ZWwtY29sb3ItcGlja2VyIHYtbW9kZWw9ImVkaXRpbmdCbG9jay5wcm9wcy5jb2xvciIgc2l6ZT0ic21hbGwiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5a+56b2QIj4KICAgICAgICAgICAgICAgIDxlbC1zZWxlY3Qgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLmFsaWduIj4KICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5bGF5LitIiB2YWx1ZT0iY2VudGVyIiAvPgogICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlt6blr7npvZAiIHZhbHVlPSJsZWZ0IiAvPgogICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlj7Plr7npvZAiIHZhbHVlPSJyaWdodCIgLz4KICAgICAgICAgICAgICAgIDwvZWwtc2VsZWN0PgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8IS0tIOWvjOaWh+acrCAtLT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImVkaXRpbmdCbG9jay50eXBlID09PSAncmljaF90ZXh0JyI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0iSFRNTCI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLmh0bWwiIHR5cGU9InRleHRhcmVhIiA6cm93cz0iNiIgcGxhY2Vob2xkZXI9IjxwPi4uLjwvcD4iIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5a+56b2QIj4KICAgICAgICAgICAgICAgIDxlbC1zZWxlY3Qgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLmFsaWduIj4KICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5bGF5LitIiB2YWx1ZT0iY2VudGVyIiAvPgogICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlt6blr7npvZAiIHZhbHVlPSJsZWZ0IiAvPgogICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlj7Plr7npvZAiIHZhbHVlPSJyaWdodCIgLz4KICAgICAgICAgICAgICAgIDwvZWwtc2VsZWN0PgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8IS0tIOWAkuiuoeaXtiAtLT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImVkaXRpbmdCbG9jay50eXBlID09PSAnY291bnRkb3duJyI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5paH5qGIIj4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nQmxvY2sucHJvcHMubGFiZWwiIHBsYWNlaG9sZGVyPSLot53mtLvliqjnu5PmnZ/ov5jmnIkgLi4uIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuaIquatouaXtumXtCI+CiAgICAgICAgICAgICAgICA8ZWwtZGF0ZS1waWNrZXIgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLmRlYWRsaW5lIiB0eXBlPSJkYXRldGltZSIgdmFsdWUtZm9ybWF0PSJZWVlZLU1NLUREVEhIOm1tOnNzIiBzdHlsZT0id2lkdGg6MTAwJSIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgICAgPCEtLSDooajljZUgLS0+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSB2LWlmPSJlZGl0aW5nQmxvY2sudHlwZSA9PT0gJ2Zvcm0nIj4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLmjInpkq7mlofmoYgiPgogICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9ImVkaXRpbmdCbG9jay5wcm9wcy5zdWJtaXRfYnV0dG9uLnRleHQiIHBsYWNlaG9sZGVyPSLnq4vljbPpooblj5YiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5oyJ6ZKu6aKc6ImyIj4KICAgICAgICAgICAgICAgIDxlbC1jb2xvci1waWNrZXIgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLnN1Ym1pdF9idXR0b24uY29sb3IiIGNvbG9yLWZvcm1hdD0iaGV4IiAvPgogICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiPnt7IGVkaXRpbmdCbG9jay5wcm9wcy5zdWJtaXRfYnV0dG9uLmNvbG9yIHx8ICfot5/pmo/lk4HniYzoibInIH19PC9zcGFuPgogICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiB2LWlmPSJlZGl0aW5nQmxvY2sucHJvcHMuc3VibWl0X2J1dHRvbi5jb2xvciIgbGluayB0eXBlPSJwcmltYXJ5IiBzaXplPSJzbWFsbCIgQGNsaWNrPSJlZGl0aW5nQmxvY2sucHJvcHMuc3VibWl0X2J1dHRvbi5jb2xvciA9ICcnIj7kvb/nlKjlk4HniYzoibI8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLpopHmjqciPgogICAgICAgICAgICAgICAgPGVsLXNlbGVjdCB2LW1vZGVsPSJlZGl0aW5nQmxvY2sucHJvcHMucmF0ZV9saW1pdCIgc3R5bGU9IndpZHRoOjEwMCUiPgogICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLml6DpmZDliLYiIHZhbHVlPSJub25lIiAvPgogICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLmr4/orr7lpIfmr4/lpKkgMSDmrKEiIHZhbHVlPSJwZXJfZGV2aWNlX2RheSIgLz4KICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5q+P5omL5py65Y+35q+P5aSpIDEg5qyhIiB2YWx1ZT0icGVyX3Bob25lX2RheSIgLz4KICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5q+P5b6u5L+h55So5oi35q+P5aSpIDEg5qyhIiB2YWx1ZT0icGVyX29wZW5pZF9kYXkiIC8+CiAgICAgICAgICAgICAgICA8L2VsLXNlbGVjdD4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZGl2aWRlcj7ooajljZXlrZfmrrU8L2VsLWRpdmlkZXI+CiAgICAgICAgICAgICAgPGRpdiB2LWlmPSIhZWRpdGluZ0Jsb2NrLnByb3BzLmZpZWxkcz8ubGVuZ3RoIiBjbGFzcz0iaGludCIgc3R5bGU9Im1hcmdpbi1ib3R0b206OHB4Ij7mmoLml6DlrZfmrrXvvIzngrnlh7vkuIvmlrnmjInpkq7mt7vliqA8L2Rpdj4KICAgICAgICAgICAgICA8ZGl2IHYtZm9yPSIoZiwgZmkpIGluIGVkaXRpbmdCbG9jay5wcm9wcy5maWVsZHMiIDprZXk9ImYua2V5ICsgZmkiIGNsYXNzPSJvcHQtcm93IiBzdHlsZT0ibWFyZ2luLWJvdHRvbTo2cHgiPgogICAgICAgICAgICAgICAgPGVsLXRhZyBzaXplPSJzbWFsbCIgOnR5cGU9ImYucmVxdWlyZWQgPyAnZGFuZ2VyJyA6ICdpbmZvJyIgc3R5bGU9ImZsZXgtc2hyaW5rOjAiPnt7IGYubGFiZWwgfHwgZi5rZXkgfX08L2VsLXRhZz4KICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJoaW50IiBzdHlsZT0iZmxleDoxO292ZXJmbG93OmhpZGRlbjt0ZXh0LW92ZXJmbG93OmVsbGlwc2lzIj57eyBmaWVsZExhYmVsKGYudHlwZSkgfX08L3NwYW4+CiAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJFZGl0IiBzaXplPSJzbWFsbCIgQGNsaWNrPSJlZGl0Rm9ybUZpZWxkKGZpKSIgLz4KICAgICAgICAgICAgICAgIDxlbC1idXR0b24gOmljb249IkRlbGV0ZSIgc2l6ZT0ic21hbGwiIHR5cGU9ImRhbmdlciIgcGxhaW4gQGNsaWNrPSJlZGl0aW5nQmxvY2sucHJvcHMuZmllbGRzLnNwbGljZShmaSwxKSIgLz4KICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJQbHVzIiBzaXplPSJzbWFsbCIgcGxhaW4gQGNsaWNrPSJhZGRGb3JtRmllbGQiPua3u+WKoOWtl+autTwvZWwtYnV0dG9uPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8IS0tIOmakOengeWjsOaYjiAtLT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImVkaXRpbmdCbG9jay50eXBlID09PSAncHJpdmFjeSciPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWQr+eUqCI+CiAgICAgICAgICAgICAgICA8ZWwtc3dpdGNoIHYtbW9kZWw9ImVkaXRpbmdCbG9jay5wcm9wcy5lbmFibGVkIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0iZWRpdGluZ0Jsb2NrLnByb3BzLmVuYWJsZWQgIT09IGZhbHNlIiBsYWJlbD0i5paH5qGIIj4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nQmxvY2sucHJvcHMudGV4dCIgcGxhY2Vob2xkZXI9IuaIkeW3sumYheivu+W5tuWQjOaEj+OAiuWuouaIt+makOengeWNj+iuruOAiyIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIHYtaWY9ImVkaXRpbmdCbG9jay5wcm9wcy5lbmFibGVkICE9PSBmYWxzZSIgbGFiZWw9IuWNj+iurumTvuaOpSI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLnVybCIgcGxhY2Vob2xkZXI9Imh0dHBzOi8vLi4u77yI5Y+v6YCJ77yJIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8IS0tIOaIkOWKn+inhuWbviAtLT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImVkaXRpbmdCbG9jay50eXBlID09PSAnc3VjY2VzcyciPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuW8ueeql+agh+mimCI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLnRpdGxlIiBwbGFjZWhvbGRlcj0i5oKo5LuK5pel5bey6aKG5Y+W6L+HIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWJr+agh+mimCI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLnN1YnRpdGxlIiBwbGFjZWhvbGRlcj0i5q+P5Liq6K6+5aSH5q+P5aSp5Y+q6IO96aKG5Y+W5LiA5qyhIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9Iueggeagh+etviI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0Jsb2NrLnByb3BzLmNvZGVfbGFiZWwiIHBsYWNlaG9sZGVyPSLmgqjnmoTlhZHmjaLnoIEiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5bqV6YOo5o+Q56S6Ij4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nQmxvY2sucHJvcHMuZm9vdGVyX3RpcCIgcGxhY2Vob2xkZXI9Iuivt+WcqOe7iOerr+mhtemdoui+k+WFpeatpOeggei/m+ihjOaguOmUgCIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9IiFbJ2hlYWRlcicsJ2ltYWdlJywndmlkZW8nLCd0ZXh0JywncmljaF90ZXh0JywnY291bnRkb3duJywnZm9ybScsJ3ByaXZhY3knLCdzdWNjZXNzJywnZGl2aWRlciddLmluY2x1ZGVzKGVkaXRpbmdCbG9jay50eXBlKSI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbT48c3BhbiBjbGFzcz0iaGludCI+5peg5Y+v6YWN572u6aG5PC9zcGFuPjwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgPC9lbC1mb3JtPgogICAgICAgICAgPHRlbXBsYXRlICNmb290ZXI+CiAgICAgICAgICAgIDxlbC1idXR0b24gQGNsaWNrPSJibG9ja0RsZ1Zpc2libGUgPSBmYWxzZSI+5Y+W5raIPC9lbC1idXR0b24+CiAgICAgICAgICAgIDxlbC1idXR0b24gdHlwZT0icHJpbWFyeSIgQGNsaWNrPSJjb21taXRCbG9jayI+56Gu5a6aPC9lbC1idXR0b24+CiAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgIDwvZWwtZGlhbG9nPgoKICAgICAgICA8IS0tIOihqOWNleWtl+autee8lui+keWZqCBkaWFsb2fvvIhmb3JtIOWMuuWdl+eahOWtkOe8lui+ke+8iSAtLT4KICAgICAgICA8ZWwtZGlhbG9nIHYtbW9kZWw9ImZpZWxkRGxnVmlzaWJsZSIgOnRpdGxlPSJg57yW6L6R5a2X5q6177yaJHtmaWVsZExhYmVsKGVkaXRpbmdGaWVsZC50eXBlKX1gIiB3aWR0aD0iNTYwcHgiIGRlc3Ryb3ktb24tY2xvc2U+CiAgICAgICAgICA8ZWwtZm9ybSBsYWJlbC13aWR0aD0iMTAwcHgiIGxhYmVsLXBvc2l0aW9uPSJsZWZ0Ij4KICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5a2X5q61IGtleSIgcmVxdWlyZWQ+CiAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9ImVkaXRpbmdGaWVsZC5rZXkiIHBsYWNlaG9sZGVyPSLlpoIgbmFtZSAvIHBob25lIiAvPgogICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5qCH562+Ij4KICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0ZpZWxkLmxhYmVsIiBwbGFjZWhvbGRlcj0i5oKo55qE56ew5ZG8IiAvPgogICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5b+F5aGrIj4KICAgICAgICAgICAgICA8ZWwtc3dpdGNoIHYtbW9kZWw9ImVkaXRpbmdGaWVsZC5yZXF1aXJlZCIgLz4KICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0iWyd0ZXh0JywndGVsJywnc2VsZWN0JywnY2hlY2tib3gnLCdtdWx0aXNlbGVjdCddLmluY2x1ZGVzKGVkaXRpbmdGaWVsZC50eXBlKSIgbGFiZWw9IuWNoOS9jeespiI+CiAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9ImVkaXRpbmdGaWVsZC5wbGFjZWhvbGRlciIgLz4KICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0iWyd0ZXh0JywndGVsJ10uaW5jbHVkZXMoZWRpdGluZ0ZpZWxkLnR5cGUpIiBsYWJlbD0i5qCh6aqM5q2j5YiZIj4KICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0ZpZWxkLnZhbGlkYXRlX3JlZ2V4IiBwbGFjZWhvbGRlcj0i5aaCIF4xWzMtOV1cXGR7OX0kIiAvPgogICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPGVsLWZvcm0taXRlbSB2LWlmPSJbJ3RleHQnLCd0ZWwnXS5pbmNsdWRlcyhlZGl0aW5nRmllbGQudHlwZSkiIGxhYmVsPSLplJnor6/mj5DnpLoiPgogICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nRmllbGQuZXJyb3JfbXNnIiBwbGFjZWhvbGRlcj0i6K+35aGr5YaZLi4uIiAvPgogICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KCiAgICAgICAgICAgIDx0ZW1wbGF0ZSB2LWlmPSJbJ3JhZGlvJywnc2VsZWN0JywnZ2VuZGVyJywnbXVsdGlzZWxlY3QnXS5pbmNsdWRlcyhlZGl0aW5nRmllbGQudHlwZSkiPgogICAgICAgICAgICAgIDxlbC1kaXZpZGVyPumAiemhuTwvZWwtZGl2aWRlcj4KICAgICAgICAgICAgICA8ZGl2IHYtZm9yPSIob3B0LCBpKSBpbiBlZGl0aW5nRmllbGQub3B0aW9ucyIgOmtleT0iaSIgY2xhc3M9Im9wdC1yb3ciPgogICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9Im9wdC52YWx1ZSIgcGxhY2Vob2xkZXI9InZhbHVlIiBzdHlsZT0id2lkdGg6MTIwcHgiIC8+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0ib3B0LmxhYmVsIiBwbGFjZWhvbGRlcj0i5pi+56S65paH5a2XIiAvPgogICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtaWY9ImVkaXRpbmdGaWVsZC50eXBlID09PSAncmFkaW8nIiB2LW1vZGVsPSJvcHQuc3VibGFiZWwiIHBsYWNlaG9sZGVyPSLlia/moIfpopjvvIjlj6/pgInvvIkiIC8+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1pZj0iZWRpdGluZ0ZpZWxkLnR5cGUgPT09ICdyYWRpbyciIHYtbW9kZWw9Im9wdC5pY29uIiBwbGFjZWhvbGRlcj0i5Zu+5qCHIGVtb2ppIiBzdHlsZT0id2lkdGg6ODBweCIgLz4KICAgICAgICAgICAgICAgIDxlbC1idXR0b24gOmljb249IkRlbGV0ZSIgdHlwZT0iZGFuZ2VyIiBwbGFpbiBzaXplPSJzbWFsbCIgQGNsaWNrPSJlZGl0aW5nRmllbGQub3B0aW9ucy5zcGxpY2UoaSwxKSIgLz4KICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJQbHVzIiBzaXplPSJzbWFsbCIgcGxhaW4gQGNsaWNrPSJlZGl0aW5nRmllbGQub3B0aW9ucy5wdXNoKHt2YWx1ZTonJyxsYWJlbDonJyxzdWJsYWJlbDonJyxpY29uOicnfSkiPgogICAgICAgICAgICAgICAg5re75Yqg6YCJ6aG5CiAgICAgICAgICAgICAgPC9lbC1idXR0b24+CiAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICA8L2VsLWZvcm0+CiAgICAgICAgICA8dGVtcGxhdGUgI2Zvb3Rlcj4KICAgICAgICAgICAgPGVsLWJ1dHRvbiBAY2xpY2s9ImZpZWxkRGxnVmlzaWJsZSA9IGZhbHNlIj7lj5bmtog8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgPGVsLWJ1dHRvbiB0eXBlPSJwcmltYXJ5IiBAY2xpY2s9ImNvbW1pdEZpZWxkIj7noa7lrpo8L2VsLWJ1dHRvbj4KICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC1kaWFsb2c+CiAgICAgIDwvZWwtdGFiLXBhbmU+CgogICAgICA8IS0tID09PT09IExFRCDlpKflsY8gPT09PT0gLS0+CiAgICAgIDxlbC10YWItcGFuZSBsYWJlbD0iTEVEIOWkp+WxjyIgbmFtZT0ibGVkIj4KICAgICAgICA8ZGl2IGNsYXNzPSJsZWQtbGF5b3V0Ij4KICAgICAgICAgIDwhLS0g5bem77ya57yW6L6RIC0tPgogICAgICAgICAgPGRpdiBjbGFzcz0ibGVkLWVkaXQtY29sIj4KICAgICAgICAgICAgPGVsLXRhYnMgdi1tb2RlbD0ibGVkUGFnZVRhYiIgY2xhc3M9ImxlZC1wYWdlLXRhYnMiPgogICAgICAgICAgICAgIDxlbC10YWItcGFuZSBsYWJlbD0iUGFnZSAx77yI6aaW6aG15LqM57u056CB77yJIiBuYW1lPSJwYWdlMSI+CiAgICAgICAgICAgICAgICA8IS0tIFBhZ2UgMSDog4zmma8gLS0+CiAgICAgICAgICAgICAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iY2ZnLWNhcmQiPgogICAgICAgICAgICAgICAgICA8dGVtcGxhdGUgI2hlYWRlcj48c3BhbiBjbGFzcz0iY2FyZC10aXRsZSI+6aG16Z2i6IOM5pmvPC9zcGFuPjwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSI4MHB4IiBsYWJlbC1wb3NpdGlvbj0ibGVmdCI+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i57G75Z6LIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1zZWxlY3Qgdi1tb2RlbD0ibGVkRm9ybS5wYWdlMV9iYWNrZ3JvdW5kLnR5cGUiPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLnuq/oibIiIHZhbHVlPSJjb2xvciIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5Zu+54mHIiB2YWx1ZT0iaW1hZ2UiIC8+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuinhumikSIgdmFsdWU9InZpZGVvIiAvPgogICAgICAgICAgICAgICAgICAgICAgPC9lbC1zZWxlY3Q+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSB2LWlmPSJsZWRGb3JtLnBhZ2UxX2JhY2tncm91bmQudHlwZSA9PT0gJ2NvbG9yJyIgbGFiZWw9IuminOiJsuWAvCI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0ibGVkRm9ybS5wYWdlMV9iYWNrZ3JvdW5kLnZhbHVlIiBwbGFjZWhvbGRlcj0iIzBhMGEwYSIgLz4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1jb2xvci1waWNrZXIgdi1tb2RlbD0ibGVkRm9ybS5wYWdlMV9iYWNrZ3JvdW5kLnZhbHVlIiBzaXplPSJzbWFsbCIgc3R5bGU9Im1hcmdpbi1sZWZ0OjhweCIgLz4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIHYtZWxzZSBsYWJlbD0i5Zu+54mHL+inhumikSI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtdXBsb2FkIDpzaG93LWZpbGUtbGlzdD0iZmFsc2UiIDpodHRwLXJlcXVlc3Q9IihvcHQpID0+IG9uVXBsb2FkQmxvY2tJbWFnZShvcHQsIGxlZEZvcm0ucGFnZTFfYmFja2dyb3VuZCwgJ3ZhbHVlJykiIGFjY2VwdD0iaW1hZ2UvKix2aWRlby9tcDQsdmlkZW8vd2VibSI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gOmljb249IlBpY3R1cmUiPuS4iuS8oDwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgPC9lbC11cGxvYWQ+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIHYtaWY9ImxlZEZvcm0ucGFnZTFfYmFja2dyb3VuZC52YWx1ZSIgOmljb249IkRlbGV0ZSIgdHlwZT0iZGFuZ2VyIiBwbGFpbiBzaXplPSJzbWFsbCIgc3R5bGU9Im1hcmdpbi1sZWZ0OjhweCIgQGNsaWNrPSJsZWRGb3JtLnBhZ2UxX2JhY2tncm91bmQgPSB7IHR5cGU6ICdjb2xvcicsIHZhbHVlOiAnIzBhMGEwYScsIGZpdDogJ2NvdmVyJyB9Ij7liKDpmaQ8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbWFnZSB2LWlmPSJsZWRGb3JtLnBhZ2UxX2JhY2tncm91bmQudHlwZSA9PT0gJ2ltYWdlJyAmJiBsZWRGb3JtLnBhZ2UxX2JhY2tncm91bmQudmFsdWUiIDpzcmM9ImxlZEZvcm0ucGFnZTFfYmFja2dyb3VuZC52YWx1ZSIgZml0PSJjb250YWluIiBzdHlsZT0id2lkdGg6MTIwcHg7aGVpZ2h0OjgwcHg7Ym9yZGVyLXJhZGl1czo2cHg7bWFyZ2luLWxlZnQ6MTJweDtiYWNrZ3JvdW5kOiMwMDAiIC8+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0ibGVkRm9ybS5wYWdlMV9iYWNrZ3JvdW5kLnZhbHVlIiBwbGFjZWhvbGRlcj0i5oiW57KY6LS0IFVSTCIgc3R5bGU9Im1hcmdpbi10b3A6OHB4IiAvPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0ibGVkRm9ybS5wYWdlMV9iYWNrZ3JvdW5kLnR5cGUgPT09ICdpbWFnZScgJiYgbGVkRm9ybS5wYWdlMV9iYWNrZ3JvdW5kLnZhbHVlIiBsYWJlbD0i5Zu+54mH6YCC5bqUIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1yYWRpby1ncm91cCB2LW1vZGVsPSJsZWRGb3JtLnBhZ2UxX2JhY2tncm91bmQuZml0Ij4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiB2YWx1ZT0iY292ZXIiPuWhq+WFheijgeWJqjwvZWwtcmFkaW8tYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tYnV0dG9uIHZhbHVlPSJjb250YWluIj7lrozmlbTmmL7npLo8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiB2YWx1ZT0iZmlsbCI+5ouJ5Ly46ZO65ruhPC9lbC1yYWRpby1idXR0b24+CiAgICAgICAgICAgICAgICAgICAgICA8L2VsLXJhZGlvLWdyb3VwPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICA8L2VsLWZvcm0+CiAgICAgICAgICAgICAgICA8L2VsLWNhcmQ+CgogICAgICAgICAgICAgICAgPCEtLSBQYWdlIDEg5Yy65Z2X5YiX6KGoIC0tPgogICAgICAgICAgICAgICAgPGVsLWNhcmQgc2hhZG93PSJuZXZlciIgY2xhc3M9ImNmZy1jYXJkIj4KICAgICAgICAgICAgICAgICAgPHRlbXBsYXRlICNoZWFkZXI+CiAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImNhcmQtdGl0bGUiPuWMuuWdlzwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICA8c3BhbiBjbGFzcz0iaGludCI+5YWxIHt7IGxlZEZvcm0ucGFnZTFfYmxvY2tzLmxlbmd0aCB9fSDkuKo8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaGRyLXNwYWNlciIgLz4KICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24gQGNvbW1hbmQ9Iih0KSA9PiBhZGRMZWRCbG9jaygncGFnZTEnLCB0KSI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9InByaW1hcnkiIHNpemU9InNtYWxsIiA6aWNvbj0iUGx1cyI+5re75Yqg5Yy65Z2XPC9lbC1idXR0b24+CiAgICAgICAgICAgICAgICAgICAgICA8dGVtcGxhdGUgI2Ryb3Bkb3duPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24tbWVudT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJpbWFnZSI+5Zu+54mHPC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9InZpZGVvIj7op4bpopE8L2VsLWRyb3Bkb3duLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLWl0ZW0gY29tbWFuZD0idGV4dCI+5paH5pysPC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9InJpY2hfdGV4dCI+5a+M5paH5pysPC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9ImRpdmlkZXIiPuWIhuWJsue6vzwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJjb3VudGRvd24iPuWAkuiuoeaXtjwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJxcl9jb2RlIj7kuoznu7TnoIE8L2VsLWRyb3Bkb3duLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZWwtZHJvcGRvd24tbWVudT4KICAgICAgICAgICAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1kcm9wZG93bj4KICAgICAgICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgPGVsLWVtcHR5IHYtaWY9IiFsZWRGb3JtLnBhZ2UxX2Jsb2Nrcy5sZW5ndGgiIGRlc2NyaXB0aW9uPSLlsJrmnKrphY3nva7ljLrlnZciIDppbWFnZS1zaXplPSI2MCIgLz4KICAgICAgICAgICAgICAgICAgPGRpdiB2LWVsc2UgY2xhc3M9Iml0ZW0tbGlzdCI+CiAgICAgICAgICAgICAgICAgICAgPGRpdiB2LWZvcj0iKGIsIGkpIGluIGxlZEZvcm0ucGFnZTFfYmxvY2tzIiA6a2V5PSJiLmlkIiBjbGFzcz0iaXRlbS1yb3ciIGRyYWdnYWJsZT0idHJ1ZSIgOmNsYXNzPSJ7ICdpcy1kcmFnLW92ZXInOiBkcmFnT3ZlckluZGV4ID09PSAnbDEnICsgaSB9IiBAZHJhZ3N0YXJ0PSJkcmFnRnJvbUluZGV4ID0gaSIgQGRyYWdvdmVyLnByZXZlbnQ9ImRyYWdPdmVySW5kZXggPSAnbDEnICsgaSIgQGRyYWdsZWF2ZT0iZHJhZ092ZXJJbmRleCA9ICcnIiBAZHJvcD0ibW92ZVRvTGVkKGxlZEZvcm0ucGFnZTFfYmxvY2tzLCBkcmFnRnJvbUluZGV4LCBpKTsgZHJhZ092ZXJJbmRleCA9ICcnIiBAZHJhZ2VuZD0iZHJhZ092ZXJJbmRleCA9ICcnIj4KICAgICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJkcmFnLWhhbmRsZSIgdGl0bGU9IuaLluaLveaOkuW6jyI+4qC/PC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaXRlbS1pbmZvIj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLXRhZyBzaXplPSJzbWFsbCI+e3sgbGVkQmxvY2tMYWJlbChiLnR5cGUpIH19PC9lbC10YWc+CiAgICAgICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJpdGVtLXN1bW1hcnkiPnt7IGJsb2NrU3VtbWFyeShiKSB9fTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaXRlbS1hY3Rpb25zIj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iQXJyb3dVcCIgOmRpc2FibGVkPSJpID09PSAwIiBAY2xpY2s9Im1vdmVMZWRCbG9jaygncGFnZTEnLCBpLCAtMSkiIGNpcmNsZSBzaXplPSJzbWFsbCIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iQXJyb3dEb3duIiA6ZGlzYWJsZWQ9ImkgPT09IGxlZEZvcm0ucGFnZTFfYmxvY2tzLmxlbmd0aCAtIDEiIEBjbGljaz0ibW92ZUxlZEJsb2NrKCdwYWdlMScsIGksIDEpIiBjaXJjbGUgc2l6ZT0ic21hbGwiIC8+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gOmljb249IkVkaXQiIEBjbGljaz0iZWRpdExlZEJsb2NrKCdwYWdlMScsIGkpIiBjaXJjbGUgc2l6ZT0ic21hbGwiIC8+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gOmljb249IkRlbGV0ZSIgdHlwZT0iZGFuZ2VyIiBwbGFpbiBAY2xpY2s9InJlbW92ZUxlZEJsb2NrKCdwYWdlMScsIGkpIiBjaXJjbGUgc2l6ZT0ic21hbGwiIC8+CiAgICAgICAgICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgICAgICA8L2VsLWNhcmQ+CiAgICAgICAgICAgICAgPC9lbC10YWItcGFuZT4KCiAgICAgICAgICAgICAgPGVsLXRhYi1wYW5lIGxhYmVsPSJQYWdlIDLvvIjlhZHmjaLpobXvvIkiIG5hbWU9InBhZ2UyIj4KICAgICAgICAgICAgICAgIDwhLS0gUGFnZSAyIOiDjOaZryAtLT4KICAgICAgICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCI+CiAgICAgICAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPjxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7pobXpnaLog4zmma88L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgPGVsLWZvcm0gbGFiZWwtd2lkdGg9IjgwcHgiIGxhYmVsLXBvc2l0aW9uPSJsZWZ0Ij4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLnsbvlnosiPgogICAgICAgICAgICAgICAgICAgICAgPGVsLXNlbGVjdCB2LW1vZGVsPSJsZWRGb3JtLnBhZ2UyX2JhY2tncm91bmQudHlwZSI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9Iue6r+iJsiIgdmFsdWU9ImNvbG9yIiAvPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlm77niYciIHZhbHVlPSJpbWFnZSIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i6KeG6aKRIiB2YWx1ZT0idmlkZW8iIC8+CiAgICAgICAgICAgICAgICAgICAgICA8L2VsLXNlbGVjdD4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIHYtaWY9ImxlZEZvcm0ucGFnZTJfYmFja2dyb3VuZC50eXBlID09PSAnY29sb3InIiBsYWJlbD0i6aKc6Imy5YC8Ij4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJsZWRGb3JtLnBhZ2UyX2JhY2tncm91bmQudmFsdWUiIHBsYWNlaG9sZGVyPSIjMGEwYTBhIiAvPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWNvbG9yLXBpY2tlciB2LW1vZGVsPSJsZWRGb3JtLnBhZ2UyX2JhY2tncm91bmQudmFsdWUiIHNpemU9InNtYWxsIiBzdHlsZT0ibWFyZ2luLWxlZnQ6OHB4IiAvPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1lbHNlIGxhYmVsPSLlm77niYcv6KeG6aKRIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC11cGxvYWQgOnNob3ctZmlsZS1saXN0PSJmYWxzZSIgOmh0dHAtcmVxdWVzdD0iKG9wdCkgPT4gb25VcGxvYWRCbG9ja0ltYWdlKG9wdCwgbGVkRm9ybS5wYWdlMl9iYWNrZ3JvdW5kLCAndmFsdWUnKSIgYWNjZXB0PSJpbWFnZS8qLHZpZGVvL21wNCx2aWRlby93ZWJtIj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iUGljdHVyZSI+5LiK5LygPC9lbC1idXR0b24+CiAgICAgICAgICAgICAgICAgICAgICA8L2VsLXVwbG9hZD4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gdi1pZj0ibGVkRm9ybS5wYWdlMl9iYWNrZ3JvdW5kLnZhbHVlIiA6aWNvbj0iRGVsZXRlIiB0eXBlPSJkYW5nZXIiIHBsYWluIHNpemU9InNtYWxsIiBzdHlsZT0ibWFyZ2luLWxlZnQ6OHB4IiBAY2xpY2s9ImxlZEZvcm0ucGFnZTJfYmFja2dyb3VuZCA9IHsgdHlwZTogJ2NvbG9yJywgdmFsdWU6ICcjMGEwYTBhJywgZml0OiAnY292ZXInIH0iPuWIoOmZpDwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWltYWdlIHYtaWY9ImxlZEZvcm0ucGFnZTJfYmFja2dyb3VuZC50eXBlID09PSAnaW1hZ2UnICYmIGxlZEZvcm0ucGFnZTJfYmFja2dyb3VuZC52YWx1ZSIgOnNyYz0ibGVkRm9ybS5wYWdlMl9iYWNrZ3JvdW5kLnZhbHVlIiBmaXQ9ImNvbnRhaW4iIHN0eWxlPSJ3aWR0aDoxMjBweDtoZWlnaHQ6ODBweDtib3JkZXItcmFkaXVzOjZweDttYXJnaW4tbGVmdDoxMnB4O2JhY2tncm91bmQ6IzAwMCIgLz4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJsZWRGb3JtLnBhZ2UyX2JhY2tncm91bmQudmFsdWUiIHBsYWNlaG9sZGVyPSLmiJbnspjotLQgVVJMIiBzdHlsZT0ibWFyZ2luLXRvcDo4cHgiIC8+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSB2LWlmPSJsZWRGb3JtLnBhZ2UyX2JhY2tncm91bmQudHlwZSA9PT0gJ2ltYWdlJyAmJiBsZWRGb3JtLnBhZ2UyX2JhY2tncm91bmQudmFsdWUiIGxhYmVsPSLlm77niYfpgILlupQiPgogICAgICAgICAgICAgICAgICAgICAgPGVsLXJhZGlvLWdyb3VwIHYtbW9kZWw9ImxlZEZvcm0ucGFnZTJfYmFja2dyb3VuZC5maXQiPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tYnV0dG9uIHZhbHVlPSJjb3ZlciI+5aGr5YWF6KOB5YmqPC9lbC1yYWRpby1idXR0b24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1yYWRpby1idXR0b24gdmFsdWU9ImNvbnRhaW4iPuWujOaVtOaYvuekujwvZWwtcmFkaW8tYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tYnV0dG9uIHZhbHVlPSJmaWxsIj7mi4nkvLjpk7rmu6E8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgIDwvZWwtcmFkaW8tZ3JvdXA+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybT4KICAgICAgICAgICAgICAgIDwvZWwtY2FyZD4KCiAgICAgICAgICAgICAgICA8IS0tIFBhZ2UgMiDljLrlnZfliJfooaggLS0+CiAgICAgICAgICAgICAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iY2ZnLWNhcmQiPgogICAgICAgICAgICAgICAgICA8dGVtcGxhdGUgI2hlYWRlcj4KICAgICAgICAgICAgICAgICAgICA8c3BhbiBjbGFzcz0iY2FyZC10aXRsZSI+5Yy65Z2XPC9zcGFuPgogICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJoaW50Ij7lhbEge3sgbGVkRm9ybS5wYWdlMl9ibG9ja3MubGVuZ3RoIH19IOS4qjwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJoZHItc3BhY2VyIiAvPgogICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93biBAY29tbWFuZD0iKHQpID0+IGFkZExlZEJsb2NrKCdwYWdlMicsIHQpIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1idXR0b24gdHlwZT0icHJpbWFyeSIgc2l6ZT0ic21hbGwiIDppY29uPSJQbHVzIj7mt7vliqDljLrlnZc8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgIDx0ZW1wbGF0ZSAjZHJvcGRvd24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1tZW51PgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9ImltYWdlIj7lm77niYc8L2VsLWRyb3Bkb3duLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLWl0ZW0gY29tbWFuZD0idmlkZW8iPuinhumikTwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJ0ZXh0Ij7mlofmnKw8L2VsLWRyb3Bkb3duLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLWl0ZW0gY29tbWFuZD0icmljaF90ZXh0Ij7lr4zmlofmnKw8L2VsLWRyb3Bkb3duLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWRyb3Bkb3duLWl0ZW0gY29tbWFuZD0iZGl2aWRlciI+5YiG5Ymy57q/PC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9ImNvdW50ZG93biI+5YCS6K6h5pe2PC9lbC1kcm9wZG93bi1pdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1kcm9wZG93bi1pdGVtIGNvbW1hbmQ9InFyX2NvZGUiPuS6jOe7tOeggTwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICA8ZWwtZHJvcGRvd24taXRlbSBjb21tYW5kPSJyZWRlZW0iPumihuWPluekvOWTgTwvZWwtZHJvcGRvd24taXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9lbC1kcm9wZG93bi1tZW51PgogICAgICAgICAgICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgICA8L2VsLWRyb3Bkb3duPgogICAgICAgICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICAgICAgICA8ZWwtZW1wdHkgdi1pZj0iIWxlZEZvcm0ucGFnZTJfYmxvY2tzLmxlbmd0aCIgZGVzY3JpcHRpb249IuWwmuacqumFjee9ruWMuuWdlyIgOmltYWdlLXNpemU9IjYwIiAvPgogICAgICAgICAgICAgICAgICA8ZGl2IHYtZWxzZSBjbGFzcz0iaXRlbS1saXN0Ij4KICAgICAgICAgICAgICAgICAgICA8ZGl2IHYtZm9yPSIoYiwgaSkgaW4gbGVkRm9ybS5wYWdlMl9ibG9ja3MiIDprZXk9ImIuaWQiIGNsYXNzPSJpdGVtLXJvdyIgZHJhZ2dhYmxlPSJ0cnVlIiA6Y2xhc3M9InsgJ2lzLWRyYWctb3Zlcic6IGRyYWdPdmVySW5kZXggPT09ICdsMicgKyBpIH0iIEBkcmFnc3RhcnQ9ImRyYWdGcm9tSW5kZXggPSBpIiBAZHJhZ292ZXIucHJldmVudD0iZHJhZ092ZXJJbmRleCA9ICdsMicgKyBpIiBAZHJhZ2xlYXZlPSJkcmFnT3ZlckluZGV4ID0gJyciIEBkcm9wPSJtb3ZlVG9MZWQobGVkRm9ybS5wYWdlMl9ibG9ja3MsIGRyYWdGcm9tSW5kZXgsIGkpOyBkcmFnT3ZlckluZGV4ID0gJyciIEBkcmFnZW5kPSJkcmFnT3ZlckluZGV4ID0gJyciPgogICAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImRyYWctaGFuZGxlIiB0aXRsZT0i5ouW5ou95o6S5bqPIj7ioL88L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJpdGVtLWluZm8iPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtdGFnIHNpemU9InNtYWxsIj57eyBsZWRCbG9ja0xhYmVsKGIudHlwZSkgfX08L2VsLXRhZz4KICAgICAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9Iml0ZW0tc3VtbWFyeSI+e3sgYmxvY2tTdW1tYXJ5KGIpIH19PC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJpdGVtLWFjdGlvbnMiPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJBcnJvd1VwIiA6ZGlzYWJsZWQ9ImkgPT09IDAiIEBjbGljaz0ibW92ZUxlZEJsb2NrKCdwYWdlMicsIGksIC0xKSIgY2lyY2xlIHNpemU9InNtYWxsIiAvPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJBcnJvd0Rvd24iIDpkaXNhYmxlZD0iaSA9PT0gbGVkRm9ybS5wYWdlMl9ibG9ja3MubGVuZ3RoIC0gMSIgQGNsaWNrPSJtb3ZlTGVkQmxvY2soJ3BhZ2UyJywgaSwgMSkiIGNpcmNsZSBzaXplPSJzbWFsbCIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iRWRpdCIgQGNsaWNrPSJlZGl0TGVkQmxvY2soJ3BhZ2UyJywgaSkiIGNpcmNsZSBzaXplPSJzbWFsbCIgLz4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iRGVsZXRlIiB0eXBlPSJkYW5nZXIiIHBsYWluIEBjbGljaz0icmVtb3ZlTGVkQmxvY2soJ3BhZ2UyJywgaSkiIGNpcmNsZSBzaXplPSJzbWFsbCIgLz4KICAgICAgICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICAgIDwvZWwtY2FyZD4KICAgICAgICAgICAgICA8L2VsLXRhYi1wYW5lPgoKICAgICAgICAgICAgICA8IS0tID09PT09IOS4u+mimO+8iExFRCDnlKjvvIkgPT09PT0gLS0+CiAgICAgICAgICAgICAgPGVsLXRhYi1wYW5lIGxhYmVsPSLkuLvpopgiIG5hbWU9ImxlZC10aGVtZSI+CiAgICAgICAgICAgICAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iY2ZnLWNhcmQiPgogICAgICAgICAgICAgICAgICA8dGVtcGxhdGUgI2hlYWRlcj48c3BhbiBjbGFzcz0iY2FyZC10aXRsZSI+5ZOB54mM6Imy5b2pPC9zcGFuPjwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSIxMDBweCIgbGFiZWwtcG9zaXRpb249ImxlZnQiPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWTgeeJjOS4u+iJsiI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtY29sb3ItcGlja2VyIHYtbW9kZWw9InRoZW1lRm9ybS5icmFuZF9jb2xvciIgc2hvdy1hbHBoYSBjb2xvci1mb3JtYXQ9ImhleCIgLz4KICAgICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJoaW50Ij57eyB0aGVtZUZvcm0uYnJhbmRfY29sb3IgfX08L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i6L6F5Yqp6ImyIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1jb2xvci1waWNrZXIgdi1tb2RlbD0idGhlbWVGb3JtLmFjY2VudF9jb2xvciIgc2hvdy1hbHBoYSBjb2xvci1mb3JtYXQ9ImhleCIgLz4KICAgICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJoaW50Ij57eyB0aGVtZUZvcm0uYWNjZW50X2NvbG9yIH19PC9zcGFuPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuaWh+Wtl+S4u+iJsiI+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtY29sb3ItcGlja2VyIHYtbW9kZWw9InRoZW1lRm9ybS50ZXh0X2NvbG9yIiBzaG93LWFscGhhIGNvbG9yLWZvcm1hdD0iaGV4IiAvPgogICAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiPnt7IHRoZW1lRm9ybS50ZXh0X2NvbG9yIH19PC9zcGFuPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICA8L2VsLWZvcm0+CiAgICAgICAgICAgICAgICA8L2VsLWNhcmQ+CgogICAgICAgICAgICAgICAgPGVsLWNhcmQgc2hhZG93PSJuZXZlciIgY2xhc3M9ImNmZy1jYXJkIj4KICAgICAgICAgICAgICAgICAgPHRlbXBsYXRlICNoZWFkZXI+PHNwYW4gY2xhc3M9ImNhcmQtdGl0bGUiPkxvZ28gLyBGYXZpY29uPC9zcGFuPjwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSIxMDBweCIgbGFiZWwtcG9zaXRpb249ImxlZnQiPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IkxvZ28iPgogICAgICAgICAgICAgICAgICAgICAgPGVsLXVwbG9hZAogICAgICAgICAgICAgICAgICAgICAgICA6c2hvdy1maWxlLWxpc3Q9ImZhbHNlIgogICAgICAgICAgICAgICAgICAgICAgICA6aHR0cC1yZXF1ZXN0PSIob3B0KSA9PiB1cGxvYWRGaWxlKCdsb2dvJywgb3B0KSIKICAgICAgICAgICAgICAgICAgICAgICAgYWNjZXB0PSJpbWFnZS9wbmcsaW1hZ2UvanBlZyxpbWFnZS9zdmcreG1sIj4KICAgICAgICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iUGljdHVyZSI+5LiK5LygIExvZ288L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgICAgICAgIDwvZWwtdXBsb2FkPgogICAgICAgICAgICAgICAgICAgICAgPGVsLWltYWdlCiAgICAgICAgICAgICAgICAgICAgICAgIHYtaWY9InRoZW1lPy5sb2dvX3VybCIKICAgICAgICAgICAgICAgICAgICAgICAgOnNyYz0idGhlbWUubG9nb191cmwiCiAgICAgICAgICAgICAgICAgICAgICAgIGZpdD0iY29udGFpbiIKICAgICAgICAgICAgICAgICAgICAgICAgc3R5bGU9ImhlaWdodDo0MHB4O21hcmdpbi1sZWZ0OjEycHg7YmFja2dyb3VuZDojMjIyO2JvcmRlci1yYWRpdXM6NHB4O3BhZGRpbmc6NHB4IiAvPgogICAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IkZhdmljb24iPgogICAgICAgICAgICAgICAgICAgICAgPGVsLXVwbG9hZAogICAgICAgICAgICAgICAgICAgICAgICA6c2hvdy1maWxlLWxpc3Q9ImZhbHNlIgogICAgICAgICAgICAgICAgICAgICAgICA6aHR0cC1yZXF1ZXN0PSIob3B0KSA9PiB1cGxvYWRGaWxlKCdmYXZpY29uJywgb3B0KSIKICAgICAgICAgICAgICAgICAgICAgICAgYWNjZXB0PSJpbWFnZS9wbmcsaW1hZ2UveC1pY29uLGltYWdlL3N2Zyt4bWwiPgogICAgICAgICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJQaWN0dXJlIj7kuIrkvKAgRmF2aWNvbjwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgICAgICAgPC9lbC11cGxvYWQ+CiAgICAgICAgICAgICAgICAgICAgICA8ZWwtaW1hZ2UKICAgICAgICAgICAgICAgICAgICAgICAgdi1pZj0idGhlbWU/LmZhdmljb25fdXJsIgogICAgICAgICAgICAgICAgICAgICAgICA6c3JjPSJ0aGVtZS5mYXZpY29uX3VybCIKICAgICAgICAgICAgICAgICAgICAgICAgZml0PSJjb250YWluIgogICAgICAgICAgICAgICAgICAgICAgICBzdHlsZT0id2lkdGg6MzJweDtoZWlnaHQ6MzJweDttYXJnaW4tbGVmdDoxMnB4O2JhY2tncm91bmQ6IzIyMjtib3JkZXItcmFkaXVzOjRweDtwYWRkaW5nOjJweCIgLz4KICAgICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtPgogICAgICAgICAgICAgICAgPC9lbC1jYXJkPgoKICAgICAgICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCI+CiAgICAgICAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPjxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7lrZfkvZM8L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICAgICAgICAgICAgPGVsLWZvcm0gbGFiZWwtd2lkdGg9IjEwMHB4IiBsYWJlbC1wb3NpdGlvbj0ibGVmdCI+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5a2X5L2T5pePIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1zZWxlY3Qgdi1tb2RlbD0idGhlbWVGb3JtLmZvbnRfZmFtaWx5IiBzdHlsZT0id2lkdGg6MTAwJSI+CiAgICAgICAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24gdi1mb3I9ImYgaW4gZm9udFByZXNldHMiIDprZXk9ImYudmFsdWUiIDpsYWJlbD0iZi5sYWJlbCIgOnZhbHVlPSJmLnZhbHVlIiAvPgogICAgICAgICAgICAgICAgICAgICAgPC9lbC1zZWxlY3Q+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i6Ieq5a6a5LmJIj4KICAgICAgICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJ0aGVtZUZvcm0uZm9udF9mYW1pbHkiIHBsYWNlaG9sZGVyPSflpoIgIk5vdG8gU2FucyBTQyIsIHNhbnMtc2VyaWYnIC8+CiAgICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgIDwvZWwtZm9ybT4KICAgICAgICAgICAgICAgIDwvZWwtY2FyZD4KCiAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJSZWZyZXNoTGVmdCIgQGNsaWNrPSJyZXNldFRoZW1lIiBzaXplPSJzbWFsbCIgc3R5bGU9Im1hcmdpbi1yaWdodDo4cHgiPumHjee9ruS4u+mimDwvZWwtYnV0dG9uPgogICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiB0eXBlPSJwcmltYXJ5IiA6aWNvbj0iQ2hlY2siIDpsb2FkaW5nPSJzYXZpbmciIHNpemU9InNtYWxsIiBAY2xpY2s9InNhdmVUaGVtZSI+5L+d5a2Y5Li76aKYPC9lbC1idXR0b24+CiAgICAgICAgICAgICAgPC9lbC10YWItcGFuZT4KICAgICAgICAgICAgPC9lbC10YWJzPgoKICAgICAgICAgICAgPGRpdiBjbGFzcz0iZm9vdGVyLWJhciI+CiAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iUmVmcmVzaExlZnQiIEBjbGljaz0icmVzZXRMZWQiPumHjee9rjwvZWwtYnV0dG9uPgogICAgICAgICAgICAgIDxlbC1idXR0b24gdHlwZT0icHJpbWFyeSIgOmljb249IkNoZWNrIiA6bG9hZGluZz0ic2F2aW5nIiBAY2xpY2s9InNhdmVMZWQiPuS/neWtmOiNieeovzwvZWwtYnV0dG9uPgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDwvZGl2PgoKICAgICAgICAgIDwhLS0g5Y+z77ya56uW5bGPIGlmcmFtZSDpooTop4ggLS0+CiAgICAgICAgICA8ZGl2IGNsYXNzPSJsZWQtcHJldmlldy1jb2wiPgogICAgICAgICAgICA8ZGl2IGNsYXNzPSJwcmV2aWV3LWZyYW1lLXdyYXAiPgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9InByZXZpZXctdG9vbGJhciI+CiAgICAgICAgICAgICAgICA8c3BhbiBjbGFzcz0iY2FyZC10aXRsZSI+5aSn5bGP6aKE6KeIPC9zcGFuPgogICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiPnt7IGxlZFN0YXR1cyA9PT0gJ3B1Ymxpc2hlZCcgPyBg57q/5LiKIHYke2xlZD8uY3VycmVudF92ZXJzaW9ufWAgOiAn6I2J56i/JyB9fTwvc3Bhbj4KICAgICAgICAgICAgICAgIDxkaXYgY2xhc3M9Imhkci1zcGFjZXIiIC8+CiAgICAgICAgICAgICAgICA8ZWwtc2VsZWN0IHYtbW9kZWw9InByZXZpZXdNYWNoaW5lSWQiIHNpemU9InNtYWxsIiBwbGFjZWhvbGRlcj0i6YCJ5oup6K6+5aSHIiBzdHlsZT0id2lkdGg6MTYwcHgiPgogICAgICAgICAgICAgICAgICA8ZWwtb3B0aW9uCiAgICAgICAgICAgICAgICAgICAgdi1mb3I9Im0gaW4gcHJvamVjdE1hY2hpbmVzIiA6a2V5PSJtLmlkIgogICAgICAgICAgICAgICAgICAgIDpsYWJlbD0ibS5tYWNoaW5lX2lkIiA6dmFsdWU9Im0ubWFjaGluZV9pZCIgLz4KICAgICAgICAgICAgICAgIDwvZWwtc2VsZWN0PgogICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiBzaXplPSJzbWFsbCIgOmljb249IlJlZnJlc2giIEBjbGljaz0icmVmcmVzaExlZFByZXZpZXciIC8+CiAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ibGVkLWZyYW1lIiB2LWlmPSJwcmV2aWV3TWFjaGluZUlkIj4KICAgICAgICAgICAgICAgIDxpZnJhbWUgcmVmPSJsZWRQcmV2aWV3SWZyYW1lIiA6c3JjPSJsZWRQcmV2aWV3VXJsIiBjbGFzcz0ibGVkLWlmcmFtZSIgLz4KICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICA8ZWwtZW1wdHkgdi1lbHNlIGRlc2NyaXB0aW9uPSLlhYjpgInorr7lpIfmn6XnnIvpooTop4giIDppbWFnZS1zaXplPSI2MCIgLz4KICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJwcmV2aWV3LWhpbnQiPgogICAgICAgICAgICAgICAgPGVsLWljb24+PEluZm9GaWxsZWQgLz48L2VsLWljb24+CiAgICAgICAgICAgICAgICDnq5blsY8gOToxNiDpooTop4jvvJvmraPlvI/pg6jnvbLml7YgUXQgV2ViVmlldyDlsIblhajlsY/liqDovb0gL2xlZC97bWFjaGluZX0vCiAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgPC9kaXY+CiAgICAgICAgPC9kaXY+CgogICAgICAgIDwhLS0g5Yy65Z2X57yW6L6RIGRpYWxvZyAtLT4KICAgICAgICA8ZWwtZGlhbG9nIHYtbW9kZWw9ImxlZEJsb2NrRGxnVmlzaWJsZSIgOnRpdGxlPSJg57yW6L6RICR7bGVkQmxvY2tMYWJlbChlZGl0aW5nTGVkQmxvY2sudHlwZSl9IOWMuuWdl2AiIHdpZHRoPSI1NDBweCIgZGVzdHJveS1vbi1jbG9zZT4KICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSIxMTBweCIgbGFiZWwtcG9zaXRpb249ImxlZnQiPgogICAgICAgICAgICA8IS0tIOmAmueUqO+8muWbvueJhy/op4bpopEgLS0+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSB2LWlmPSJlZGl0aW5nTGVkQmxvY2sudHlwZSA9PT0gJ2ltYWdlJyI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5Zu+54mHIj4KICAgICAgICAgICAgICAgIDxlbC11cGxvYWQgOnNob3ctZmlsZS1saXN0PSJmYWxzZSIgOmh0dHAtcmVxdWVzdD0iKG9wdCkgPT4gb25VcGxvYWRCbG9ja0ltYWdlKG9wdCwgZWRpdGluZ0xlZEJsb2NrLnByb3BzKSIgYWNjZXB0PSJpbWFnZS8qIj4KICAgICAgICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iUGljdHVyZSI+5LiK5Lyg5Zu+54mHPC9lbC1idXR0b24+CiAgICAgICAgICAgICAgICA8L2VsLXVwbG9hZD4KICAgICAgICAgICAgICAgIDxlbC1pbWFnZSB2LWlmPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMudXJsIiA6c3JjPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMudXJsIiBmaXQ9ImNvdmVyIiBzdHlsZT0id2lkdGg6MTIwcHg7aGVpZ2h0OjgwcHg7Ym9yZGVyLXJhZGl1czo2cHg7bWFyZ2luLWxlZnQ6MTJweCIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLmm7/ku6PmlofmnKwiPgogICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9ImVkaXRpbmdMZWRCbG9jay5wcm9wcy5hbHQiIHBsYWNlaG9sZGVyPSJhbHQiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5YWo5bGPIj4KICAgICAgICAgICAgICAgIDxlbC1zd2l0Y2ggdi1tb2RlbD0iZWRpdGluZ0xlZEJsb2NrLnByb3BzLmZ1bGxzY3JlZW4iIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSB2LWlmPSJlZGl0aW5nTGVkQmxvY2sudHlwZSA9PT0gJ3ZpZGVvJyI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i6KeG6aKRIFVSTCI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0xlZEJsb2NrLnByb3BzLnVybCIgcGxhY2Vob2xkZXI9Ii5tcDQgLyAud2VibSIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLoh6rliqjmkq3mlL4iPgogICAgICAgICAgICAgICAgPGVsLXN3aXRjaCB2LW1vZGVsPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMuYXV0b3BsYXkiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5b6q546vIj4KICAgICAgICAgICAgICAgIDxlbC1zd2l0Y2ggdi1tb2RlbD0iZWRpdGluZ0xlZEJsb2NrLnByb3BzLmxvb3AiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICAgIDwhLS0g5paH5pysIC0tPgogICAgICAgICAgICA8dGVtcGxhdGUgdi1pZj0iZWRpdGluZ0xlZEJsb2NrLnR5cGUgPT09ICd0ZXh0JyI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5YaF5a65Ij4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMuY29udGVudCIgdHlwZT0idGV4dGFyZWEiIDpyb3dzPSIzIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWtl+WPtyI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0xlZEJsb2NrLnByb3BzLmZvbnRfc2l6ZSIgcGxhY2Vob2xkZXI9IuWmgiAxOHB4IOaIliAxLjJyZW0iIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i6aKc6ImyIj4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMuY29sb3IiIHBsYWNlaG9sZGVyPSIjZmZmZmZmIiAvPgogICAgICAgICAgICAgICAgPGVsLWNvbG9yLXBpY2tlciB2LW1vZGVsPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMuY29sb3IiIHNpemU9InNtYWxsIiBzdHlsZT0ibWFyZ2luLWxlZnQ6OHB4IiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWvuem9kCI+CiAgICAgICAgICAgICAgICA8ZWwtc2VsZWN0IHYtbW9kZWw9ImVkaXRpbmdMZWRCbG9jay5wcm9wcy5hbGlnbiI+CiAgICAgICAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuWxheS4rSIgdmFsdWU9ImNlbnRlciIgLz4KICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5bem5a+56b2QIiB2YWx1ZT0ibGVmdCIgLz4KICAgICAgICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5Y+z5a+56b2QIiB2YWx1ZT0icmlnaHQiIC8+CiAgICAgICAgICAgICAgICA8L2VsLXNlbGVjdD4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLnspfnu4YiPgogICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9ImVkaXRpbmdMZWRCbG9jay5wcm9wcy53ZWlnaHQiIHBsYWNlaG9sZGVyPSJib2xkIC8gNzAwIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWklui+uei3nSI+CiAgICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0iZWRpdGluZ0xlZEJsb2NrLnByb3BzLm1hcmdpbiIgcGxhY2Vob2xkZXI9IuWmgiAxMnB4IDAiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICAgIDwhLS0g5a+M5paH5pysIC0tPgogICAgICAgICAgICA8dGVtcGxhdGUgdi1pZj0iZWRpdGluZ0xlZEJsb2NrLnR5cGUgPT09ICdyaWNoX3RleHQnIj4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSJIVE1MIj4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMuaHRtbCIgdHlwZT0idGV4dGFyZWEiIDpyb3dzPSI2IiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8IS0tIOWAkuiuoeaXtiAtLT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImVkaXRpbmdMZWRCbG9jay50eXBlID09PSAnY291bnRkb3duJyI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5qCH562+Ij4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMubGFiZWwiIHBsYWNlaG9sZGVyPSLot53nu5PmnZ8iIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5oiq5q2i5pe26Ze0Ij4KICAgICAgICAgICAgICAgIDxlbC1kYXRlLXBpY2tlciB2LW1vZGVsPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMuZGVhZGxpbmUiIHR5cGU9ImRhdGV0aW1lIiB2YWx1ZS1mb3JtYXQ9IllZWVktTU0tREQgSEg6bW06c3MiIHN0eWxlPSJ3aWR0aDoxMDAlIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8IS0tIOS6jOe7tOeggSAtLT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImVkaXRpbmdMZWRCbG9jay50eXBlID09PSAncXJfY29kZSciPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuS6jOe7tOeggeWbviI+CiAgICAgICAgICAgICAgICA8ZWwtdXBsb2FkIDpzaG93LWZpbGUtbGlzdD0iZmFsc2UiIDpodHRwLXJlcXVlc3Q9IihvcHQpID0+IG9uVXBsb2FkQmxvY2tJbWFnZShvcHQsIGVkaXRpbmdMZWRCbG9jay5wcm9wcywgJ2ltYWdlX3VybCcpIiBhY2NlcHQ9ImltYWdlLyoiPgogICAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJQaWN0dXJlIj7kuIrkvKDlm77niYc8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgIDwvZWwtdXBsb2FkPgogICAgICAgICAgICAgICAgPGVsLWltYWdlIHYtaWY9ImVkaXRpbmdMZWRCbG9jay5wcm9wcy5pbWFnZV91cmwiIDpzcmM9ImVkaXRpbmdMZWRCbG9jay5wcm9wcy5pbWFnZV91cmwiIGZpdD0iY29udGFpbiIgc3R5bGU9IndpZHRoOjgwcHg7aGVpZ2h0OjgwcHg7Ym9yZGVyLXJhZGl1czo0cHg7bWFyZ2luLWxlZnQ6OHB4IiAvPgogICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiPuS4jeWhq+WImeeUqOmhueebrum7mOiupOS6jOe7tOeggTwvc3Bhbj4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLmoIfnrb4iPgogICAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9ImVkaXRpbmdMZWRCbG9jay5wcm9wcy5sYWJlbCIgcGxhY2Vob2xkZXI9IuaJq+eggeWFs+azqCDCtyDpooblj5bmoLflk4EiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5bC65a+4Ij4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dC1udW1iZXIgdi1tb2RlbD0iZWRpdGluZ0xlZEJsb2NrLnByb3BzLnNpemUiIDptaW49IjEwMCIgOm1heD0iODAwIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8IS0tIOmihuWPluekvOWTgSAtLT4KICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImVkaXRpbmdMZWRCbG9jay50eXBlID09PSAncmVkZWVtJyI+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5oyJ6ZKu5paH5qGIIj4KICAgICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMuY2xhaW1fYnRuX3RleHQiIHBsYWNlaG9sZGVyPSLnq4vljbPpooblj5bnpLzlk4EiIC8+CiAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5pi+56S656CB6L6T5YWlIj4KICAgICAgICAgICAgICAgIDxlbC1zd2l0Y2ggdi1tb2RlbD0iZWRpdGluZ0xlZEJsb2NrLnByb3BzLnNob3dfY29kZV9pbnB1dCIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIHYtaWY9ImVkaXRpbmdMZWRCbG9jay5wcm9wcy5zaG93X2NvZGVfaW5wdXQiIGxhYmVsPSLnoIHplb/luqYiPgogICAgICAgICAgICAgICAgPGVsLWlucHV0LW51bWJlciB2LW1vZGVsPSJlZGl0aW5nTGVkQmxvY2sucHJvcHMuY29kZV9sZW5ndGgiIDptaW49IjQiIDptYXg9IjEwIiAvPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuaYvuekuuWVhuWTgee9keagvCI+CiAgICAgICAgICAgICAgICA8ZWwtc3dpdGNoIHYtbW9kZWw9ImVkaXRpbmdMZWRCbG9jay5wcm9wcy5zaG93X3Byb2R1Y3RfZ3JpZCIgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgIDwvZWwtZm9ybT4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZm9vdGVyPgogICAgICAgICAgICA8ZWwtYnV0dG9uIEBjbGljaz0ibGVkQmxvY2tEbGdWaXNpYmxlID0gZmFsc2UiPuWPlua2iDwvZWwtYnV0dG9uPgogICAgICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9InByaW1hcnkiIEBjbGljaz0iY29tbWl0TGVkQmxvY2siPuehruWumjwvZWwtYnV0dG9uPgogICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLWRpYWxvZz4KICAgICAgPC9lbC10YWItcGFuZT4KCiAgICAgIDwhLS0gPT09PT0gQS9CIOWunumqjO+8iFBoYXNlIDIuM++8iSA9PT09PSAtLT4KICAgICAgPGVsLXRhYi1wYW5lIGxhYmVsPSJBL0Ig5a6e6aqMIiBuYW1lPSJleHBlcmltZW50Ij4KICAgICAgICA8IS0tIOaXoOWunumqjO+8mkNUQSDliJvlu7ogLS0+CiAgICAgICAgPGVsLWVtcHR5IHYtaWY9IiFleHBlcmltZW50IiBkZXNjcmlwdGlvbj0i5bCa5pyq5Yib5bu6IEEvQiDlrp7pqowiIDppbWFnZS1zaXplPSI4MCI+CiAgICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9InByaW1hcnkiIDppY29uPSJQbHVzIiBAY2xpY2s9Im9wZW5DcmVhdGVFeHBEaWFsb2ciPuWIm+W7uuWunumqjDwvZWwtYnV0dG9uPgogICAgICAgICAgPGRpdiBzdHlsZT0ibWFyZ2luLXRvcDoxMHB4OyBjb2xvcjogdmFyKC0tZWwtdGV4dC1jb2xvci1zZWNvbmRhcnkpOyBmb250LXNpemU6IDEzcHg7Ij4KICAgICAgICAgICAg5Yib5bu65ZCO5Lya5Lul5b2T5YmNIEg1IOmFjee9ruS4uuOAjOWvueeFp+e7hCBB44CN77yM5L2g5YaN57yW6L6R5Y+Y5L2TIEIg6L+b6KGM5a+55q+UCiAgICAgICAgICA8L2Rpdj4KICAgICAgICA8L2VsLWVtcHR5PgoKICAgICAgICA8IS0tIOacieWunumqjO+8mueKtuaAgeWNoSArIOWPmOS9kyArIOe7n+iuoSAtLT4KICAgICAgICA8dGVtcGxhdGUgdi1lbHNlPgogICAgICAgICAgPGVsLWNhcmQgc2hhZG93PSJuZXZlciIgY2xhc3M9ImNmZy1jYXJkIj4KICAgICAgICAgICAgPHRlbXBsYXRlICNoZWFkZXI+CiAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImNhcmQtdGl0bGUiPnt7IGV4cGVyaW1lbnQubmFtZSB9fTwvc3Bhbj4KICAgICAgICAgICAgICA8ZWwtdGFnIDp0eXBlPSJleHBTdGF0dXNUYWcoZXhwZXJpbWVudC5zdGF0dXMpIiBzaXplPSJzbWFsbCIgc3R5bGU9Im1hcmdpbi1sZWZ0OjhweCI+CiAgICAgICAgICAgICAgICB7eyBleHBTdGF0dXNMYWJlbChleHBlcmltZW50LnN0YXR1cykgfX0KICAgICAgICAgICAgICA8L2VsLXRhZz4KICAgICAgICAgICAgICA8ZWwtdGFnIHYtaWY9ImV4cGVyaW1lbnQud2lubmVyIiB0eXBlPSJzdWNjZXNzIiBlZmZlY3Q9ImRhcmsiIHNpemU9InNtYWxsIiBzdHlsZT0ibWFyZ2luLWxlZnQ6NnB4Ij4KICAgICAgICAgICAgICAgIOiDnOWHuiB7eyBleHBlcmltZW50Lndpbm5lciB9fQogICAgICAgICAgICAgIDwvZWwtdGFnPgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9Imhkci1zcGFjZXIiIC8+CiAgICAgICAgICAgICAgPCEtLSDnirbmgIHmnLrmjInpkq4gLS0+CiAgICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImV4cGVyaW1lbnQuc3RhdHVzID09PSAnZHJhZnQnIj4KICAgICAgICAgICAgICAgIDxlbC1idXR0b24gdHlwZT0ic3VjY2VzcyIgOmljb249IlZpZGVvUGxheSIgOmxvYWRpbmc9ImV4cEFjdGluZyIgQGNsaWNrPSJleHBUcmFuc2l0aW9uKCdydW5uaW5nJykiPgogICAgICAgICAgICAgICAgICDlkK/liqjlrp7pqowKICAgICAgICAgICAgICAgIDwvZWwtYnV0dG9uPgogICAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgPHRlbXBsYXRlIHYtZWxzZS1pZj0iZXhwZXJpbWVudC5zdGF0dXMgPT09ICdydW5uaW5nJyI+CiAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJWaWRlb1BhdXNlIiA6bG9hZGluZz0iZXhwQWN0aW5nIiBAY2xpY2s9ImV4cFRyYW5zaXRpb24oJ3N0b3BwZWQnKSI+5pqC5YGcPC9lbC1idXR0b24+CiAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9InByaW1hcnkiIDppY29uPSJDaXJjbGVDaGVjayIgOmxvYWRpbmc9ImV4cEFjdGluZyIgQGNsaWNrPSJvcGVuQ29uY2x1ZGVEaWFsb2ciPgogICAgICAgICAgICAgICAgICDnu5PmoYgKICAgICAgICAgICAgICAgIDwvZWwtYnV0dG9uPgogICAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgPHRlbXBsYXRlIHYtZWxzZS1pZj0iZXhwZXJpbWVudC5zdGF0dXMgPT09ICdzdG9wcGVkJyI+CiAgICAgICAgICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9InN1Y2Nlc3MiIDppY29uPSJWaWRlb1BsYXkiIDpsb2FkaW5nPSJleHBBY3RpbmciIEBjbGljaz0iZXhwVHJhbnNpdGlvbigncnVubmluZycpIj7nu6fnu608L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICAgIDxlbC1idXR0b24gdHlwZT0icHJpbWFyeSIgOmljb249IkNpcmNsZUNoZWNrIiA6bG9hZGluZz0iZXhwQWN0aW5nIiBAY2xpY2s9Im9wZW5Db25jbHVkZURpYWxvZyI+57uT5qGIPC9lbC1idXR0b24+CiAgICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJEb3dubG9hZCIgQGNsaWNrPSJkb0V4cG9ydEV4cGVyaW1lbnQiPuWvvOWHuiBDU1Y8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICA8ZWwtYnV0dG9uIHYtaWY9ImV4cGVyaW1lbnQuc3RhdHVzICE9PSAncnVubmluZyciIDppY29uPSJEZWxldGUiIHR5cGU9ImRhbmdlciIgcGxhaW4gOmxvYWRpbmc9ImV4cEFjdGluZyIgQGNsaWNrPSJkZWxldGVFeHAiPgogICAgICAgICAgICAgICAg5Yig6ZmkCiAgICAgICAgICAgICAgPC9lbC1idXR0b24+CiAgICAgICAgICAgIDwvdGVtcGxhdGU+CgogICAgICAgICAgICA8ZWwtZm9ybSBsYWJlbC13aWR0aD0iMTAwcHgiIGxhYmVsLXBvc2l0aW9uPSJsZWZ0Ij4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIHYtaWY9ImV4cGVyaW1lbnQuaHlwb3RoZXNpcyIgbGFiZWw9IuWBh+iuviI+CiAgICAgICAgICAgICAgICA8c3BhbiBzdHlsZT0iY29sb3I6IHZhcigtLWVsLXRleHQtY29sb3Itc2Vjb25kYXJ5KSI+e3sgZXhwZXJpbWVudC5oeXBvdGhlc2lzIH19PC9zcGFuPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9Iua1gemHj+WIhumFjSI+CiAgICAgICAgICAgICAgICA8c3BhbiB2LWZvcj0idiBpbiBleHBlcmltZW50LnZhcmlhbnRzIiA6a2V5PSJ2LmtleSIgY2xhc3M9InNoYXJlLXRhZyI+CiAgICAgICAgICAgICAgICAgIHt7IHYua2V5IH19OiA8Yj57eyB2LnRyYWZmaWNfc2hhcmUgfX0lPC9iPgogICAgICAgICAgICAgICAgPC9zcGFuPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gdi1pZj0iZXhwZXJpbWVudC5zdGFydGVkX2F0IiBsYWJlbD0i5ZCv5Yqo5pe26Ze0Ij57eyBleHBlcmltZW50LnN0YXJ0ZWRfYXQgfX08L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIHYtaWY9ImV4cGVyaW1lbnQuc3RvcHBlZF9hdCIgbGFiZWw9Iue7k+adn+aXtumXtCI+e3sgZXhwZXJpbWVudC5zdG9wcGVkX2F0IH19PC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSB2LWlmPSJleHBlcmltZW50LmNvbmNsdXNpb25fbm90ZSIgbGFiZWw9Iue7k+iuuiI+e3sgZXhwZXJpbWVudC5jb25jbHVzaW9uX25vdGUgfX08L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPC9lbC1mb3JtPgogICAgICAgICAgPC9lbC1jYXJkPgoKICAgICAgICAgIDwhLS0g5Lik5Liq5Y+Y5L2T5Y2h54mHIC0tPgogICAgICAgICAgPGRpdiBjbGFzcz0idmFyaWFudHMtZ3JpZCI+CiAgICAgICAgICAgIDxlbC1jYXJkIHYtZm9yPSJ2IGluIGV4cGVyaW1lbnQudmFyaWFudHMiIDprZXk9InYuaWQiIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCB2YXJpYW50LWNhcmQiPgogICAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPgogICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImNhcmQtdGl0bGUiPgogICAgICAgICAgICAgICAgICDlj5jkvZMge3sgdi5rZXkgfX0KICAgICAgICAgICAgICAgICAgPGVsLXRhZyBzaXplPSJzbWFsbCIgOnR5cGU9InYua2V5ID09PSAnQScgPyAnaW5mbycgOiAnd2FybmluZyciIHN0eWxlPSJtYXJnaW4tbGVmdDo2cHgiPgogICAgICAgICAgICAgICAgICAgIHt7IHYua2V5ID09PSAnQScgPyAn5a+554Wn57uEJyA6ICflrp7pqoznu4QnIH19CiAgICAgICAgICAgICAgICAgIDwvZWwtdGFnPgogICAgICAgICAgICAgICAgPC9zcGFuPgogICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0iaGRyLXNwYWNlciIgLz4KICAgICAgICAgICAgICAgIDxlbC1idXR0b24KICAgICAgICAgICAgICAgICAgdi1pZj0iZXhwZXJpbWVudC5zdGF0dXMgIT09ICdjb25jbHVkZWQnIgogICAgICAgICAgICAgICAgICBzaXplPSJzbWFsbCIgOmljb249IkVkaXQiCiAgICAgICAgICAgICAgICAgIDp0eXBlPSJ2YXJpYW50RWRpdGluZz8uaWQgPT09IHYuaWQgPyAncHJpbWFyeScgOiAnJyIKICAgICAgICAgICAgICAgICAgQGNsaWNrPSJlbnRlclZhcmlhbnRFZGl0aW5nKHYpIj4KICAgICAgICAgICAgICAgICAge3sgdmFyaWFudEVkaXRpbmc/LmlkID09PSB2LmlkID8gJ+e8lui+keS4reKApicgOiAn5ZyoIEg1IHRhYiDkuK3nvJbovpEnIH19CiAgICAgICAgICAgICAgICA8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSI4MHB4IiBsYWJlbC1wb3NpdGlvbj0ibGVmdCI+CiAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLlkI3np7AiPnt7IHYubmFtZSB9fTwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i6K+05piOIiB2LWlmPSJ2Lm5vdGUiPnt7IHYubm90ZSB9fTwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5qCH6aKYIj57eyB2Lmg1X3NuYXBzaG90LmhlYWRlcl90aXRsZSB8fCAnKOm7mOiupCknIH19PC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLmjInpkq7mlofmoYgiPnt7IHYuaDVfc25hcHNob3Quc3VibWl0X2J1dHRvbj8udGV4dCB8fCAn56uL5Y2z6aKG5Y+WJyB9fTwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5oyJ6ZKu6aKc6ImyIj4KICAgICAgICAgICAgICAgICAgPHNwYW4gdi1pZj0idi5oNV9zbmFwc2hvdC5zdWJtaXRfYnV0dG9uPy5jb2xvciIKICAgICAgICAgICAgICAgICAgICAgICAgOnN0eWxlPSJ7IGRpc3BsYXk6J2lubGluZS1ibG9jaycsIHdpZHRoOicyNHB4JywgaGVpZ2h0OicyNHB4JywgYm9yZGVyUmFkaXVzOic0cHgnLCBiYWNrZ3JvdW5kQ29sb3I6IHYuaDVfc25hcHNob3Quc3VibWl0X2J1dHRvbi5jb2xvciwgbWFyZ2luUmlnaHQ6ICc4cHgnLCB2ZXJ0aWNhbEFsaWduOiAnbWlkZGxlJyB9IiAvPgogICAgICAgICAgICAgICAgICB7eyB2Lmg1X3NuYXBzaG90LnN1Ym1pdF9idXR0b24/LmNvbG9yIHx8ICfot5/pmo/kuLvpopgnIH19CiAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgIDwhLS0g5a6e5pe257uf6K6hIC0tPgogICAgICAgICAgICAgICAgPHRlbXBsYXRlIHYtaWY9ImV4cFN0YXRzIj4KICAgICAgICAgICAgICAgICAgPGVsLWRpdmlkZXI+5a6e5pe25pWw5o2uPC9lbC1kaXZpZGVyPgogICAgICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLorr/pl64iPgogICAgICAgICAgICAgICAgICAgIDxiPnt7IHZhcmlhbnRTdGF0KHYua2V5KS52aXNpdHMgfX08L2I+CiAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiPlVWIHt7IHZhcmlhbnRTdGF0KHYua2V5KS51diB9fTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IumihueggSI+CiAgICAgICAgICAgICAgICAgICAge3sgdmFyaWFudFN0YXQodi5rZXkpLmNsYWltcyB9fQogICAgICAgICAgICAgICAgICAgIDxlbC10YWcgc2l6ZT0ic21hbGwiIDp0eXBlPSJsZWFkZXJUYWcodi5rZXkpIiBzdHlsZT0ibWFyZ2luLWxlZnQ6NnB4Ij4KICAgICAgICAgICAgICAgICAgICAgIHt7IHZhcmlhbnRTdGF0KHYua2V5KS5jbGFpbV9yYXRlIH19JQogICAgICAgICAgICAgICAgICAgIDwvZWwtdGFnPgogICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5qC46ZSAIj4KICAgICAgICAgICAgICAgICAgICB7eyB2YXJpYW50U3RhdCh2LmtleSkucmVkZWVtcyB9fQogICAgICAgICAgICAgICAgICAgIDxzcGFuIGNsYXNzPSJoaW50IiBzdHlsZT0ibWFyZ2luLWxlZnQ6OHB4Ij57eyB2YXJpYW50U3RhdCh2LmtleSkucmVkZWVtX3JhdGUgfX0lPC9zcGFuPgogICAgICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICAgICAgPC9lbC1mb3JtPgogICAgICAgICAgICA8L2VsLWNhcmQ+CiAgICAgICAgICA8L2Rpdj4KCiAgICAgICAgICA8IS0tIOaYvuiRl+aAp+aPkOekuiAtLT4KICAgICAgICAgIDxlbC1hbGVydAogICAgICAgICAgICB2LWlmPSJleHBTdGF0cz8uc2lnbmlmaWNhbmNlIgogICAgICAgICAgICA6dHlwZT0iYW55U2lnQ29uZmlkZW50ID8gJ3N1Y2Nlc3MnIDogJ2luZm8nIgogICAgICAgICAgICA6Y2xvc2FibGU9ImZhbHNlIiBzaG93LWljb24KICAgICAgICAgICAgc3R5bGU9Im1hcmdpbi10b3A6MTRweCI+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSAjdGl0bGU+CiAgICAgICAgICAgICAg5b2T5YmN6aKG5YWI5pa577yaPGI+e3sgZXhwU3RhdHMuc2lnbmlmaWNhbmNlLmxlYWRlciB8fCAnLScgfX08L2I+CiAgICAgICAgICAgICAg77yI5a+554Wn57uEIHt7IGV4cFN0YXRzLnNpZ25pZmljYW5jZS5jb250cm9sIHx8ICdBJyB9fe+8iQogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8ZGl2IHN0eWxlPSJtYXJnaW4tdG9wOjZweCI+CiAgICAgICAgICAgICAgPGRpdiB2LWZvcj0iY21wIGluIGV4cFN0YXRzLnNpZ25pZmljYW5jZS5jb21wYXJpc29ucyIgOmtleT0iY21wLnZhcmlhbnQiIHN0eWxlPSJmb250LXNpemU6MTNweDsiPgogICAgICAgICAgICAgICAgPGVsLXRhZyBzaXplPSJzbWFsbCIgOnR5cGU9ImNtcC5jb25maWRlbnQgPyAnc3VjY2VzcycgOiAnaW5mbyciIGVmZmVjdD0icGxhaW4iIHN0eWxlPSJtYXJnaW4tcmlnaHQ6NnB4Ij4KICAgICAgICAgICAgICAgICAge3sgY21wLnZhcmlhbnQgfX0gdnMge3sgY21wLnZzIH19CiAgICAgICAgICAgICAgICA8L2VsLXRhZz4KICAgICAgICAgICAgICAgIHogPSB7eyBjbXAuel9zY29yZSA/PyAn4oCUJyB9fQogICAgICAgICAgICAgICAgPHNwYW4gdi1pZj0iY21wLmNvbmZpZGVudCIgc3R5bGU9ImNvbG9yOiB2YXIoLS1lbC1jb2xvci1zdWNjZXNzKTsgbWFyZ2luLWxlZnQ6NHB4Ij7inJMg5pi+6JGXPC9zcGFuPgogICAgICAgICAgICAgICAgPHNwYW4gdi1lbHNlIHN0eWxlPSJjb2xvcjogdmFyKC0tZWwtdGV4dC1jb2xvci1zZWNvbmRhcnkpOyBtYXJnaW4tbGVmdDo0cHgiPuacqui+viA5NSUg572u5L+hPC9zcGFuPgogICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgIDxkaXYgc3R5bGU9ImNvbG9yOiB2YXIoLS1lbC10ZXh0LWNvbG9yLXNlY29uZGFyeSk7IGZvbnQtc2l6ZTogMTJweDsgbWFyZ2luLXRvcDo0cHgiPgogICAgICAgICAgICAgICAge3sgZXhwU3RhdHMuc2lnbmlmaWNhbmNlLm5vdGUgfX0KICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICA8L2VsLWFsZXJ0PgogICAgICAgIDwvdGVtcGxhdGU+CgogICAgICAgIDwhLS0g5Yib5bu65a6e6aqMIGRpYWxvZyAo5pSv5oyBIDItNCDlj5jkvZMpIC0tPgogICAgICAgIDxlbC1kaWFsb2cgdi1tb2RlbD0iY3JlYXRlRXhwRGlhbG9nIiB0aXRsZT0i5Yib5bu6IEEvQiDlrp7pqowiIHdpZHRoPSI1NjBweCI+CiAgICAgICAgICA8ZWwtZm9ybSBsYWJlbC13aWR0aD0iMTAwcHgiIGxhYmVsLXBvc2l0aW9uPSJsZWZ0Ij4KICAgICAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i5a6e6aqM5ZCN56ewIj4KICAgICAgICAgICAgICA8ZWwtaW5wdXQgdi1tb2RlbD0ibmV3RXhwLm5hbWUiIHBsYWNlaG9sZGVyPSLkvovvvJrmjInpkq7popzoibIgQS9CIiBtYXhsZW5ndGg9IjEyOCIgLz4KICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWBh+iuviI+CiAgICAgICAgICAgICAgPGVsLWlucHV0IHYtbW9kZWw9Im5ld0V4cC5oeXBvdGhlc2lzIiB0eXBlPSJ0ZXh0YXJlYSIgOnJvd3M9IjIiCiAgICAgICAgICAgICAgICBwbGFjZWhvbGRlcj0i5L6L77ya5L2/55So57qi6Imy5oyJ6ZKu5Y+v5o+Q5Y2HIEg1IOeCueWHu+eOhyIgLz4KICAgICAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWPmOS9k+aVsCI+CiAgICAgICAgICAgICAgPGVsLXJhZGlvLWdyb3VwIHYtbW9kZWw9Im5ld0V4cC52YXJpYW50X2NvdW50IiBAY2hhbmdlPSJyZWJhbGFuY2VTaGFyZXMiPgogICAgICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiA6dmFsdWU9IjIiPjIgKEEvQik8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgICAgIDxlbC1yYWRpby1idXR0b24gOnZhbHVlPSIzIj4zIChBL0IvQyk8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgICAgIDxlbC1yYWRpby1idXR0b24gOnZhbHVlPSI0Ij40IChBL0IvQy9EKTwvZWwtcmFkaW8tYnV0dG9uPgogICAgICAgICAgICAgIDwvZWwtcmFkaW8tZ3JvdXA+CiAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLmtYHph4/liIbphY0iPgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9InNoYXJlcy1ncmlkIj4KICAgICAgICAgICAgICAgIDxkaXYgdi1mb3I9IihrLCBpKSBpbiBbJ0EnLCdCJywnQycsJ0QnXS5zbGljZSgwLCBuZXdFeHAudmFyaWFudF9jb3VudCkiIDprZXk9ImsiIGNsYXNzPSJzaGFyZS1jZWxsIj4KICAgICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ic2hhcmUtbGFiZWwiPnt7IGsgfX08L2Rpdj4KICAgICAgICAgICAgICAgICAgPGVsLWlucHV0LW51bWJlcgogICAgICAgICAgICAgICAgICAgIHYtbW9kZWw9Im5ld0V4cC50cmFmZmljX3NoYXJlc1tpXSIKICAgICAgICAgICAgICAgICAgICA6bWluPSIwIiA6bWF4PSIxMDAiIDpzdGVwPSI1IgogICAgICAgICAgICAgICAgICAgIHNpemU9InNtYWxsIgogICAgICAgICAgICAgICAgICAgIHN0eWxlPSJ3aWR0aDo5MHB4IgogICAgICAgICAgICAgICAgICAgIGNvbnRyb2xzLXBvc2l0aW9uPSJyaWdodCIgLz4KICAgICAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ic2hhcmUtcGN0Ij4lPC9kaXY+CiAgICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJoaW50IiA6c3R5bGU9InsgY29sb3I6IHNoYXJlU3VtID09PSAxMDAgPyAndmFyKC0tZWwtY29sb3Itc3VjY2VzcyknIDogJ3ZhcigtLWVsLWNvbG9yLWRhbmdlciknIH0iPgogICAgICAgICAgICAgICAg5ZCI6K6hIHt7IHNoYXJlU3VtIH19Je+8iOW/hemhuyA9IDEwMO+8iQogICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgIDxlbC1idXR0b24gc2l6ZT0ic21hbGwiIGxpbmsgdHlwZT0icHJpbWFyeSIgQGNsaWNrPSJyZWJhbGFuY2VTaGFyZXMiPuWdh+WIhjwvZWwtYnV0dG9uPgogICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgIDwvZWwtZm9ybT4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZm9vdGVyPgogICAgICAgICAgICA8ZWwtYnV0dG9uIEBjbGljaz0iY3JlYXRlRXhwRGlhbG9nID0gZmFsc2UiPuWPlua2iDwvZWwtYnV0dG9uPgogICAgICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9InByaW1hcnkiIDpsb2FkaW5nPSJleHBBY3RpbmciIDpkaXNhYmxlZD0ic2hhcmVTdW0gIT09IDEwMCIgQGNsaWNrPSJkb0NyZWF0ZUV4cCI+CiAgICAgICAgICAgICAg5Yib5bu6CiAgICAgICAgICAgIDwvZWwtYnV0dG9uPgogICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLWRpYWxvZz4KCgogICAgICAgIDwhLS0g57uT5qGIIGRpYWxvZyAtLT4KICAgICAgICA8ZWwtZGlhbG9nIHYtbW9kZWw9ImNvbmNsdWRlRGlhbG9nIiB0aXRsZT0i57uT5qGI5a6e6aqMIiB3aWR0aD0iNTAwcHgiPgogICAgICAgICAgPGVsLWFsZXJ0IHR5cGU9Indhcm5pbmciIDpjbG9zYWJsZT0iZmFsc2UiIHNob3ctaWNvbgogICAgICAgICAgICAgICAgICAgIHRpdGxlPSLnu5PmoYjlkI7or6Xlrp7pqozkuI3lj6/mgaLlpI3vvIzkuJTkvJrmiorog5zlh7rlj5jkvZPnmoQgSDUg5b+r54Wn6KaG55uW5Yiw6aG555uu5Li76KGo77yI6I2J56i/54q25oCB77yM5b6F5L2g5a6h5qC45ZCO5Y+R5biD77yJIiAvPgogICAgICAgICAgPGVsLWZvcm0gbGFiZWwtd2lkdGg9IjEwMHB4IiBsYWJlbC1wb3NpdGlvbj0ibGVmdCIgc3R5bGU9Im1hcmdpbi10b3A6MTRweCI+CiAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuiDnOWHuuWPmOS9kyI+CiAgICAgICAgICAgICAgPGVsLXJhZGlvLWdyb3VwIHYtbW9kZWw9ImNvbmNsdWRlRm9ybS53aW5uZXIiPgogICAgICAgICAgICAgICAgPGVsLXJhZGlvIHYtZm9yPSJ2IGluIChleHBlcmltZW50Py52YXJpYW50cyB8fCBbXSkiIDprZXk9InYua2V5IiA6dmFsdWU9InYua2V5Ij4KICAgICAgICAgICAgICAgICAge3sgdi5rZXkgfX0ge3sgdi5uYW1lIH19CiAgICAgICAgICAgICAgICA8L2VsLXJhZGlvPgogICAgICAgICAgICAgIDwvZWwtcmFkaW8tZ3JvdXA+CiAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLnu5PorrrlpIfms6giPgogICAgICAgICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJjb25jbHVkZUZvcm0ubm90ZSIgdHlwZT0idGV4dGFyZWEiIDpyb3dzPSIyIgogICAgICAgICAgICAgICAgcGxhY2Vob2xkZXI9IuS+i++8mkIg6L2s5YyW546H5piO5pi+5pu06auY77yM572u5L+h5bqm6Laz5aSfIiAvPgogICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgIDwvZWwtZm9ybT4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZm9vdGVyPgogICAgICAgICAgICA8ZWwtYnV0dG9uIEBjbGljaz0iY29uY2x1ZGVEaWFsb2cgPSBmYWxzZSI+5Y+W5raIPC9lbC1idXR0b24+CiAgICAgICAgICAgIDxlbC1idXR0b24gdHlwZT0icHJpbWFyeSIgOmxvYWRpbmc9ImV4cEFjdGluZyIgQGNsaWNrPSJkb0NvbmNsdWRlIj7noa7orqTnu5PmoYg8L2VsLWJ1dHRvbj4KICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC1kaWFsb2c+CiAgICAgIDwvZWwtdGFiLXBhbmU+CgogICAgICA8IS0tID09PT09IOaVsOaNrueci+adv++8iFBoYXNlIDIuMu+8iSA9PT09PSAtLT4KICAgICAgPGVsLXRhYi1wYW5lIGxhYmVsPSLmlbDmja7nnIvmnb8iIG5hbWU9InN0YXRzIj4KICAgICAgICA8ZGl2IGNsYXNzPSJzdGF0cy10b29sYmFyIj4KICAgICAgICAgIDxlbC1yYWRpby1ncm91cCB2LW1vZGVsPSJzdGF0c0RheXMiIEBjaGFuZ2U9ImxvYWRGdW5uZWwiIHNpemU9InNtYWxsIj4KICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiA6dmFsdWU9IjciPui/kSA3IOWkqTwvZWwtcmFkaW8tYnV0dG9uPgogICAgICAgICAgICA8ZWwtcmFkaW8tYnV0dG9uIDp2YWx1ZT0iMTQiPui/kSAxNCDlpKk8L2VsLXJhZGlvLWJ1dHRvbj4KICAgICAgICAgICAgPGVsLXJhZGlvLWJ1dHRvbiA6dmFsdWU9IjMwIj7ov5EgMzAg5aSpPC9lbC1yYWRpby1idXR0b24+CiAgICAgICAgICA8L2VsLXJhZGlvLWdyb3VwPgogICAgICAgICAgPGRpdiBzdHlsZT0iZmxleDoxIj48L2Rpdj4KICAgICAgICAgIDxlbC1idXR0b24gc2l6ZT0ic21hbGwiIDppY29uPSJEb3dubG9hZCIgQGNsaWNrPSJkb0V4cG9ydEZ1bm5lbCI+5a+85Ye6IENTVjwvZWwtYnV0dG9uPgogICAgICAgICAgPGVsLWJ1dHRvbiBzaXplPSJzbWFsbCIgOmljb249IlJlZnJlc2giIEBjbGljaz0ibG9hZEZ1bm5lbCI+5Yi35pawPC9lbC1idXR0b24+CiAgICAgICAgPC9kaXY+CgogICAgICAgIDxkaXYgdi1sb2FkaW5nPSJzdGF0c0xvYWRpbmciPgogICAgICAgICAgPCEtLSBLUEkg5Y2h54mHIC0tPgogICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLWdyaWQiPgogICAgICAgICAgICA8ZGl2IGNsYXNzPSJrcGktY2FyZCI+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLWxhYmVsIj5INSDorr/pl648L2Rpdj4KICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJrcGktdmFsdWUiPnt7IGZ1bm5lbD8udG90YWxzLmg1X3Zpc2l0cyA/PyAwIH19PC9kaXY+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLXN1YiI+VVYge3sgZnVubmVsPy50b3RhbHMudXZfaDUgPz8gMCB9fTwvZGl2PgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLWNhcmQiPgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9ImtwaS1sYWJlbCI+TEVEIOiuv+mXrjwvZGl2PgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9ImtwaS12YWx1ZSI+e3sgZnVubmVsPy50b3RhbHMubGVkX3Zpc2l0cyA/PyAwIH19PC9kaXY+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLXN1YiI+VVYge3sgZnVubmVsPy50b3RhbHMudXZfbGVkID8/IDAgfX08L2Rpdj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgIDxkaXYgY2xhc3M9ImtwaS1jYXJkIHN1Y2Nlc3MiPgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9ImtwaS1sYWJlbCI+6aKG56CBPC9kaXY+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLXZhbHVlIj57eyBmdW5uZWw/LnRvdGFscy5jbGFpbXMgPz8gMCB9fTwvZGl2PgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9ImtwaS1zdWIiPuiuv+mXruKGkumihueggSB7eyBmdW5uZWw/LmNvbnZlcnNpb24uaDVfdmlzaXRfdG9fY2xhaW0gPz8gMCB9fSU8L2Rpdj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgIDxkaXYgY2xhc3M9ImtwaS1jYXJkIHdhcm5pbmciPgogICAgICAgICAgICAgIDxkaXYgY2xhc3M9ImtwaS1sYWJlbCI+5qC46ZSAPC9kaXY+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLXZhbHVlIj57eyBmdW5uZWw/LnRvdGFscy5yZWRlZW1zID8/IDAgfX08L2Rpdj4KICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJrcGktc3ViIj7poobnoIHihpLmoLjplIAge3sgZnVubmVsPy5jb252ZXJzaW9uLmNsYWltX3RvX3JlZGVlbSA/PyAwIH19JTwvZGl2PgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLWNhcmQgcHJpbWFyeSI+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLWxhYmVsIj7mlbTkvZPovazljJY8L2Rpdj4KICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSJrcGktdmFsdWUiPnt7IGZ1bm5lbD8uY29udmVyc2lvbi5vdmVyYWxsID8/IDAgfX0lPC9kaXY+CiAgICAgICAgICAgICAgPGRpdiBjbGFzcz0ia3BpLXN1YiI+SDUg6K6/6ZeuIOKGkiDmoLjplIA8L2Rpdj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICA8L2Rpdj4KCiAgICAgICAgICA8IS0tIOi2i+WKv+WbviAtLT4KICAgICAgICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJjZmctY2FyZCIgc3R5bGU9Im1hcmdpbi10b3A6MTRweCI+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSAjaGVhZGVyPjxzcGFuIGNsYXNzPSJjYXJkLXRpdGxlIj7mr4/ml6Xotovlir88L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICAgICAgPGRpdiByZWY9InRyZW5kQ2hhcnRFbCIgc3R5bGU9IndpZHRoOjEwMCU7IGhlaWdodDozNDBweCI+PC9kaXY+CiAgICAgICAgICA8L2VsLWNhcmQ+CgogICAgICAgICAgPCEtLSDmvI/mlpflm74gLS0+CiAgICAgICAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iY2ZnLWNhcmQiIHN0eWxlPSJtYXJnaW4tdG9wOjE0cHgiPgogICAgICAgICAgICA8dGVtcGxhdGUgI2hlYWRlcj48c3BhbiBjbGFzcz0iY2FyZC10aXRsZSI+6L2s5YyW5ryP5paXPC9zcGFuPjwvdGVtcGxhdGU+CiAgICAgICAgICAgIDxkaXYgcmVmPSJmdW5uZWxDaGFydEVsIiBzdHlsZT0id2lkdGg6MTAwJTsgaGVpZ2h0OjMwMHB4Ij48L2Rpdj4KICAgICAgICAgIDwvZWwtY2FyZD4KICAgICAgICA8L2Rpdj4KICAgICAgPC9lbC10YWItcGFuZT4KCiAgICAgIDwhLS0gPT09PT0g5Y+R5biD5Y6G5Y+yID09PT09IC0tPgogICAgICA8ZWwtdGFiLXBhbmUgbGFiZWw9IuWPkeW4g+WOhuWPsiIgbmFtZT0idmVyc2lvbnMiPgogICAgICAgIDxlbC1hbGVydCB0eXBlPSJpbmZvIiA6Y2xvc2FibGU9ImZhbHNlIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMHB4Ij4KICAgICAgICAgIOavj+asoeWPkeW4gyBINSAvIExFRCDpg73kvJrnlJ/miJDkuIDkuKrkuI3lj6/lj5jlv6vnhafjgILlj6/ku6Xpmo/ml7blm57mu5rliLDku7vmhI/ljoblj7LniYjmnKzjgIIKICAgICAgICA8L2VsLWFsZXJ0PgogICAgICAgIDxlbC10YWJsZSA6ZGF0YT0idmVyc2lvbnMiIHN0cmlwZSBzaXplPSJzbWFsbCIgZW1wdHktdGV4dD0i5pqC5peg5Y+R5biD6K6w5b2VIj4KICAgICAgICAgIDxlbC10YWJsZS1jb2x1bW4gcHJvcD0idmVyc2lvbiIgbGFiZWw9IueJiOacrCIgd2lkdGg9IjgwIj4KICAgICAgICAgICAgPHRlbXBsYXRlICNkZWZhdWx0PSJ7IHJvdyB9Ij4KICAgICAgICAgICAgICA8Yj52e3sgcm93LnZlcnNpb24gfX08L2I+CiAgICAgICAgICAgICAgPGVsLXRhZyB2LWlmPSJpc0N1cnJlbnRWZXJzaW9uKHJvdykiIHNpemU9InNtYWxsIiB0eXBlPSJzdWNjZXNzIiBlZmZlY3Q9ImRhcmsiIHN0eWxlPSJtYXJnaW4tbGVmdDo2cHgiPuW9k+WJjTwvZWwtdGFnPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgPC9lbC10YWJsZS1jb2x1bW4+CiAgICAgICAgICA8ZWwtdGFibGUtY29sdW1uIHByb3A9InBhZ2VfdHlwZSIgbGFiZWw9Iuexu+WeiyIgd2lkdGg9IjgwIj4KICAgICAgICAgICAgPHRlbXBsYXRlICNkZWZhdWx0PSJ7IHJvdyB9Ij4KICAgICAgICAgICAgICA8ZWwtdGFnIHNpemU9InNtYWxsIiA6dHlwZT0icm93LnBhZ2VfdHlwZSA9PT0gJ2g1JyA/ICdwcmltYXJ5JyA6IHJvdy5wYWdlX3R5cGUgPT09ICdsZWQnID8gJ3dhcm5pbmcnIDogJ2luZm8nIj4KICAgICAgICAgICAgICAgIHt7IHJvdy5wYWdlX3R5cGUgPT09ICdoNScgPyAnSDUnIDogcm93LnBhZ2VfdHlwZSA9PT0gJ3RoZW1lJyA/ICfkuLvpopgnIDogJ0xFRCcgfX0KICAgICAgICAgICAgICA8L2VsLXRhZz4KICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgIDwvZWwtdGFibGUtY29sdW1uPgogICAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBwcm9wPSJwdWJsaXNoZWRfYXQiIGxhYmVsPSLlj5HluIPml7bpl7QiIHdpZHRoPSIxODAiIC8+CiAgICAgICAgICA8ZWwtdGFibGUtY29sdW1uIHByb3A9InB1Ymxpc2hlZF9ieV9uYW1lIiBsYWJlbD0i5Y+R5biD5Lq6IiB3aWR0aD0iMTIwIiAvPgogICAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBwcm9wPSJub3RlIiBsYWJlbD0i5Y+R5biD6K+05piOIiAvPgogICAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBsYWJlbD0i5pON5L2cIiB3aWR0aD0iMTgwIiBhbGlnbj0icmlnaHQiPgogICAgICAgICAgICA8dGVtcGxhdGUgI2RlZmF1bHQ9Insgcm93IH0iPgogICAgICAgICAgICAgIDxlbC1idXR0b24KICAgICAgICAgICAgICAgIHNpemU9InNtYWxsIiBsaW5rIHR5cGU9InByaW1hcnkiCiAgICAgICAgICAgICAgICA6ZGlzYWJsZWQ9ImlzQ3VycmVudFZlcnNpb24ocm93KSIKICAgICAgICAgICAgICAgIEBjbGljaz0ib3BlblJlc3RvcmVEaWFsb2cocm93KSI+CiAgICAgICAgICAgICAgICA8ZWwtaWNvbj48UmVmcmVzaExlZnQgLz48L2VsLWljb24+CiAgICAgICAgICAgICAgICDlm57mu5rliLDmraTniYjmnKwKICAgICAgICAgICAgICA8L2VsLWJ1dHRvbj4KICAgICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICAgIDwvZWwtdGFibGUtY29sdW1uPgogICAgICAgIDwvZWwtdGFibGU+CgogICAgICAgIDwhLS0g5Zue5rua56Gu6K6kIGRpYWxvZyAtLT4KICAgICAgICA8ZWwtZGlhbG9nIHYtbW9kZWw9InJlc3RvcmVEaWFsb2ciIDp0aXRsZT0icmVzdG9yZVRhcmdldCA/IGDlm57mu5rliLAgdiR7cmVzdG9yZVRhcmdldC52ZXJzaW9ufWAgOiAn5Zue5ruaJyIgd2lkdGg9IjUyMHB4Ij4KICAgICAgICAgIDxkaXYgdi1pZj0icmVzdG9yZVRhcmdldCI+CiAgICAgICAgICAgIDxlbC1hbGVydCB0eXBlPSJ3YXJuaW5nIiA6Y2xvc2FibGU9ImZhbHNlIiBzaG93LWljb24KICAgICAgICAgICAgICAgICAgICAgIDp0aXRsZT0iYOWwhuaKiiAke3Jlc3RvcmVUYXJnZXQucGFnZV90eXBlID09PSAnbGVkJyA/ICdMRUQg5aSn5bGPJyA6ICdINSDokL3lnLDpobUnfSDnmoTlhoXlrrnopobnm5bkuLogdiR7cmVzdG9yZVRhcmdldC52ZXJzaW9ufSDnmoTlv6vnhadgIgogICAgICAgICAgICAgICAgICAgICAgc3R5bGU9Im1hcmdpbi1ib3R0b206MTRweCIKICAgICAgICAgICAgICAgICAgICAgIGRlc2NyaXB0aW9uPSLlj6/pgInjgIzku4XmgaLlpI3liLDojYnnqL/jgI3vvIjmjqjojZDvvIznvJbovpHlmajph4zog73nnIvliLDnu5PmnpzlkI7lho3lj5HluIPvvInvvIzmiJbjgIznq4vljbPlj5HluIPjgI3vvIjnlJ/miJDkuIDmnaHmlrDniYjmnKzlj7cgKyDnq4vljbPnlJ/mlYjliLDnur/kuIrvvIkiIC8+CgogICAgICAgICAgICA8ZWwtZm9ybSBsYWJlbC13aWR0aD0iMTIwcHgiIGxhYmVsLXBvc2l0aW9uPSJsZWZ0Ij4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLljIXlkKvkuLvpopgiPgogICAgICAgICAgICAgICAgPGVsLXN3aXRjaCB2LW1vZGVsPSJyZXN0b3JlT3B0aW9ucy5pbmNsdWRlX3RoZW1lIiAvPgogICAgICAgICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJtYXJnaW4tbGVmdDo4cHgiPuWFs+mXreWImeWPquWbnua7miB7eyByZXN0b3JlVGFyZ2V0LnBhZ2VfdHlwZSA9PT0gJ2xlZCcgPyAnTEVEJyA6ICdINScgfX0g5YaF5a6577yM5LiN5Yqo5Li76aKY6ImyPC9zcGFuPgogICAgICAgICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuWbnua7muWQjiI+CiAgICAgICAgICAgICAgICA8ZWwtcmFkaW8tZ3JvdXAgdi1tb2RlbD0icmVzdG9yZU9wdGlvbnMucHVibGlzaCI+CiAgICAgICAgICAgICAgICAgIDxlbC1yYWRpbyA6dmFsdWU9ImZhbHNlIj7ku4XmgaLlpI3liLDojYnnqL/vvIjmjqjojZDvvIk8L2VsLXJhZGlvPgogICAgICAgICAgICAgICAgICA8ZWwtcmFkaW8gOnZhbHVlPSJ0cnVlIj7nq4vljbPlj5HluIPliLDnur/kuIo8L2VsLXJhZGlvPgogICAgICAgICAgICAgICAgPC9lbC1yYWRpby1ncm91cD4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLlj5HluIPor7TmmI4iPgogICAgICAgICAgICAgICAgPGVsLWlucHV0IDp2YWx1ZT0iYOWbnua7muiHqiB2JHtyZXN0b3JlVGFyZ2V0LnZlcnNpb259YCIgZGlzYWJsZWQgLz4KICAgICAgICAgICAgICA8L2VsLWZvcm0taXRlbT4KICAgICAgICAgICAgPC9lbC1mb3JtPgogICAgICAgICAgPC9kaXY+CiAgICAgICAgICA8dGVtcGxhdGUgI2Zvb3Rlcj4KICAgICAgICAgICAgPGVsLWJ1dHRvbiBAY2xpY2s9InJlc3RvcmVEaWFsb2cgPSBmYWxzZSI+5Y+W5raIPC9lbC1idXR0b24+CiAgICAgICAgICAgIDxlbC1idXR0b24gdHlwZT0icHJpbWFyeSIgOmxvYWRpbmc9InJlc3RvcmluZyIgQGNsaWNrPSJkb1Jlc3RvcmUiPgogICAgICAgICAgICAgIHt7IHJlc3RvcmVPcHRpb25zLnB1Ymxpc2ggPyAn5Zue5rua5bm25Y+R5biDJyA6ICflm57mu5rliLDojYnnqL8nIH19CiAgICAgICAgICAgIDwvZWwtYnV0dG9uPgogICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLWRpYWxvZz4KICAgICAgPC9lbC10YWItcGFuZT4KICAgIDwvZWwtdGFicz4KICA8L2Rpdj4KPC90ZW1wbGF0ZT4KCjxzY3JpcHQgc2V0dXA+CmltcG9ydCB7IGNvbXB1dGVkLCBuZXh0VGljaywgb25Nb3VudGVkLCBvblVubW91bnRlZCwgcmVhY3RpdmUsIHJlZiwgd2F0Y2ggfSBmcm9tICd2dWUnCmltcG9ydCAqIGFzIGVjaGFydHMgZnJvbSAnZWNoYXJ0cycKaW1wb3J0IHsgdXNlUm91dGUgfSBmcm9tICd2dWUtcm91dGVyJwppbXBvcnQgeyBFbE1lc3NhZ2UsIEVsTWVzc2FnZUJveCB9IGZyb20gJ2VsZW1lbnQtcGx1cycKaW1wb3J0IHsKICBBcnJvd0Rvd24sIEFycm93TGVmdCwgQXJyb3dVcCwgQ2hlY2ssIENpcmNsZUNoZWNrLCBDbG9jaywgRGVsZXRlLCBEb3dubG9hZCwgRWRpdCwgSW5mb0ZpbGxlZCwKICBQaWN0dXJlLCBQbHVzLCBSZWZyZXNoLCBSZWZyZXNoTGVmdCwgRnVsbFNjcmVlbiwgVXBsb2FkLCBWaWRlb1BhdXNlLCBWaWRlb1BsYXksIFZpZXcKfSBmcm9tICdAZWxlbWVudC1wbHVzL2ljb25zLXZ1ZScKaW1wb3J0IHsgZ2V0UHJvamVjdCB9IGZyb20gJ0AvYXBpL3Byb2plY3RzJwppbXBvcnQgewogIGdldFByb2plY3RUaGVtZSwgdXBkYXRlUHJvamVjdFRoZW1lLAogIGdldFByb2plY3RINSwgdXBkYXRlUHJvamVjdEg1LCBwdWJsaXNoUHJvamVjdEg1LAogIGdldFByb2plY3RMZWQsIHVwZGF0ZVByb2plY3RMZWQsIHB1Ymxpc2hQcm9qZWN0TGVkLAogIGxpc3RQYWdlVmVyc2lvbnMsIHJlc3RvcmVQYWdlVmVyc2lvbiwKICBnZXRQcm9qZWN0RnVubmVsLAogIGdldEV4cGVyaW1lbnQsIGNyZWF0ZUV4cGVyaW1lbnQsIGRlbGV0ZUV4cGVyaW1lbnQsCiAgdXBkYXRlRXhwZXJpbWVudFZhcmlhbnQsIHRyYW5zaXRpb25FeHBlcmltZW50LCBnZXRFeHBlcmltZW50U3RhdHMsCiAgZXhwb3J0RnVubmVsQ3N2LCBleHBvcnRFeHBlcmltZW50Q3N2LAogIHVwbG9hZEJsb2NrSW1hZ2UsCn0gZnJvbSAnQC9hcGkvcGFnZXMnCgpjb25zdCByb3V0ZSA9IHVzZVJvdXRlKCkKY29uc3QgcHJvamVjdElkID0gTnVtYmVyKHJvdXRlLnBhcmFtcy5pZCkKCmNvbnN0IGxvYWRpbmcgPSByZWYoZmFsc2UpCmNvbnN0IHNhdmluZyA9IHJlZihmYWxzZSkKY29uc3QgcHVibGlzaGluZyA9IHJlZihmYWxzZSkKY29uc3QgYWN0aXZlVGFiID0gcmVmKCdoNScpCmNvbnN0IGg1UGFnZVRhYiA9IHJlZigncGFnZTEnKQoKLy8g6aKE6KeI5pe26Lez6L2s5Yiw5a+55bqU55qEIHRhYiDpobXpnaIKY29uc3QgcHJldmlld1VybCA9IGNvbXB1dGVkKCgpID0+IHsKICAvLyDlj5jkvZPnvJbovpHmqKHlvI/vvJppZnJhbWUg5by65Yi25riy5p+T6K+l5Y+Y5L2T77yIcHJldmlld192YXJpYW50PUF8Qu+8iQogIGlmICh2YXJpYW50RWRpdGluZy52YWx1ZSkgewogICAgcmV0dXJuIGAvcC8ke3Byb2plY3RJZH0vP3ByZXZpZXdfdmFyaWFudD0ke3ZhcmlhbnRFZGl0aW5nLnZhbHVlLmtleX0mcGFnZT0ke2g1UGFnZVRhYi52YWx1ZX0mXz0ke3ByZXZpZXdCdXN0LnZhbHVlfWAKICB9CiAgcmV0dXJuIGAvcC8ke3Byb2plY3RJZH0vP3ByZXZpZXc9MSZwYWdlPSR7aDVQYWdlVGFiLnZhbHVlfSZfPSR7cHJldmlld0J1c3QudmFsdWV9YAp9KQoKY29uc3QgcHJvamVjdCA9IHJlZihudWxsKQpjb25zdCB0aGVtZSA9IHJlZihudWxsKQpjb25zdCBoNSA9IHJlZihudWxsKQpjb25zdCBsZWQgPSByZWYobnVsbCkKY29uc3QgdmVyc2lvbnMgPSByZWYoW10pCmNvbnN0IHByb2plY3RNYWNoaW5lcyA9IGNvbXB1dGVkKCgpID0+IHByb2plY3QudmFsdWU/Lm1hY2hpbmVzIHx8IFtdKQpjb25zdCBwcmV2aWV3TWFjaGluZUlkID0gcmVmKCcnKQoKY29uc3QgdGhlbWVGb3JtID0gcmVmKHsKICBicmFuZF9jb2xvcjogJyMxNEI0NTAnLAogIGFjY2VudF9jb2xvcjogJyMwYTBhMGEnLAogIHRleHRfY29sb3I6ICcjRkZGRkZGJywKICBiYWNrZ3JvdW5kX3R5cGU6ICdjb2xvcicsCiAgYmFja2dyb3VuZF92YWx1ZTogJyMwYTBhMGEnLAogIGZvbnRfZmFtaWx5OiAnIk5vdG8gU2FucyBTQyIsIC1hcHBsZS1zeXN0ZW0sIHNhbnMtc2VyaWYnCn0pCgpjb25zdCBoNUZvcm0gPSByZWYoewogIGhlYWRlcl90aXRsZTogJycsCiAgaGVhZGVyX3N1YnRpdGxlOiAnJywKICBibG9ja3M6IFtdLAogIGZvcm1fZmllbGRzOiBbXSwKICBwcml2YWN5OiB7IGVuYWJsZWQ6IHRydWUsIHRleHQ6ICcnLCB1cmw6ICcnIH0sCiAgc3VibWl0X2J1dHRvbjogeyB0ZXh0OiAn56uL5Y2z6aKG5Y+WJywgY29sb3I6ICcnIH0sCiAgc3VjY2Vzc192aWV3OiB7IHRpdGxlOiAnJywgc3VidGl0bGU6ICcnLCBjb2RlX2xhYmVsOiAnJywgZm9vdGVyX3RpcDogJycgfSwKICByYXRlX2xpbWl0OiAncGVyX2RldmljZV9kYXknLAogIHBhZ2UxX2JhY2tncm91bmQ6IHsgdHlwZTogJ2NvbG9yJywgdmFsdWU6ICcjMGEwYTBhJywgZml0OiAnY292ZXInIH0sCiAgcGFnZTJfYmFja2dyb3VuZDogeyB0eXBlOiAnY29sb3InLCB2YWx1ZTogJyMwYTBhMGEnLCBmaXQ6ICdjb3ZlcicgfSwKICBwYWdlM19iYWNrZ3JvdW5kOiB7IHR5cGU6ICdjb2xvcicsIHZhbHVlOiAnIzBhMGEwYScsIGZpdDogJ2NvdmVyJyB9LAogIGhlYWRlcl9wb3NpdGlvbjogeyB4OiA1MCwgeTogMTAgfSwKICBidXR0b25fcG9zaXRpb246IHsgeDogNTAsIHk6IDgwIH0sCn0pCmNvbnN0IGg1U3RhdHVzID0gY29tcHV0ZWQoKCkgPT4gaDUudmFsdWU/LnN0YXR1cyB8fCAnZHJhZnQnKQpjb25zdCBsZWRTdGF0dXMgPSBjb21wdXRlZCgoKSA9PiBsZWQudmFsdWU/LnN0YXR1cyB8fCAnZHJhZnQnKQoKLy8g6aG25qCP5b6956ug77ya5qC55o2u5b2T5YmNIHRhYiDliIfmjaIKY29uc3QgY3VycmVudFN0YXR1cyA9IGNvbXB1dGVkKCgpID0+IHsKICBpZiAoYWN0aXZlVGFiLnZhbHVlID09PSAnbGVkJykgcmV0dXJuIGxlZFN0YXR1cy52YWx1ZQogIHJldHVybiBoNVN0YXR1cy52YWx1ZQp9KQpjb25zdCBjdXJyZW50QmFkZ2UgPSBjb21wdXRlZCgoKSA9PiB7CiAgaWYgKGFjdGl2ZVRhYi52YWx1ZSA9PT0gJ2xlZCcpIHsKICAgIHJldHVybiBsZWRTdGF0dXMudmFsdWUgPT09ICdwdWJsaXNoZWQnID8gYExFRCDlt7Llj5HluIMgdiR7bGVkLnZhbHVlPy5jdXJyZW50X3ZlcnNpb24gfHwgMH1gIDogJ0xFRCDojYnnqL8nCiAgfQogIGlmIChhY3RpdmVUYWIudmFsdWUgPT09ICdoNScpIHsKICAgIHJldHVybiBoNVN0YXR1cy52YWx1ZSA9PT0gJ3B1Ymxpc2hlZCcgPyBgSDUg5bey5Y+R5biDIHYke2g1LnZhbHVlPy5jdXJyZW50X3ZlcnNpb24gfHwgMH1gIDogJ0g1IOiNieeovycKICB9CiAgcmV0dXJuICfnvJbovpHkuK0nCn0pCgovLyA9PT09PT09PT09PT0gTEVEIOeKtuaAgSA9PT09PT09PT09PT0KY29uc3QgbGVkRm9ybSA9IHJlZih7CiAgaGVhZGVyX3RpdGxlOiAnJywKICBoZWFkZXJfc3VidGl0bGU6ICcnLAogIGFkczogW10sCiAgcXI6IHsgbGFiZWw6ICcnLCB1cmw6ICcnIH0sCiAgaW5wdXRfY29uZmlnOiB7IGxhYmVsOiAnJywgcGxhY2Vob2xkZXI6ICcnLCBzdWJtaXRfdGV4dDogJycsIHN1Y2Nlc3NfdGV4dDogJycgfSwKICBmb290ZXJfdGlwOiAnJywKICBwYWdlMV9ibG9ja3M6IFtdLAogIHBhZ2UyX2Jsb2NrczogW10sCiAgcGFnZTFfYmFja2dyb3VuZDogeyB0eXBlOiAnY29sb3InLCB2YWx1ZTogJyMwYTBhMGEnLCBmaXQ6ICdjb3ZlcicgfSwKICBwYWdlMl9iYWNrZ3JvdW5kOiB7IHR5cGU6ICdjb2xvcicsIHZhbHVlOiAnIzBhMGEwYScsIGZpdDogJ2NvdmVyJyB9LAp9KQpjb25zdCBsZWRQcmV2aWV3SWZyYW1lID0gcmVmKG51bGwpCmNvbnN0IGxlZFByZXZpZXdCdXN0ID0gcmVmKERhdGUubm93KCkpCmNvbnN0IGRyYWdGcm9tSW5kZXggPSByZWYoLTEpCmNvbnN0IGRyYWdPdmVySW5kZXggPSByZWYoJycpCmNvbnN0IGxlZFByZXZpZXdVcmwgPSBjb21wdXRlZCgoKSA9PiB7CiAgaWYgKCFwcmV2aWV3TWFjaGluZUlkLnZhbHVlKSByZXR1cm4gJ2Fib3V0OmJsYW5rJwogIHJldHVybiBgL2xlZC8ke3ByZXZpZXdNYWNoaW5lSWQudmFsdWV9Lz9wcm9qZWN0X2lkPSR7cHJvamVjdElkfSZfPSR7bGVkUHJldmlld0J1c3QudmFsdWV9YAp9KQpmdW5jdGlvbiByZWZyZXNoTGVkUHJldmlldygpIHsgbGVkUHJldmlld0J1c3QudmFsdWUgPSBEYXRlLm5vdygpIH0KCi8vIExFRCBwYWdlIHRhYiAod2l0aGluIExFRCB0YWIpCmNvbnN0IGxlZFBhZ2VUYWIgPSByZWYoJ3BhZ2UxJykKCi8vIExFRCBibG9jayBlZGl0aW5nCmNvbnN0IGxlZEJsb2NrRGxnVmlzaWJsZSA9IHJlZihmYWxzZSkKY29uc3QgZWRpdGluZ0xlZEJsb2NrSW5kZXggPSByZWYoLTEpCmNvbnN0IGVkaXRpbmdMZWRCbG9ja1BhZ2UgPSByZWYoJ3BhZ2UxJykKY29uc3QgZWRpdGluZ0xlZEJsb2NrID0gcmVhY3RpdmUoeyBpZDogJycsIHR5cGU6ICd0ZXh0JywgcHJvcHM6IHt9IH0pCgpjb25zdCBMRURfQkxPQ0tfTEFCRUxTID0gewogIGltYWdlOiAn5Zu+54mHJywgdmlkZW86ICfop4bpopEnLCB0ZXh0OiAn5paH5pysJywgcmljaF90ZXh0OiAn5a+M5paH5pysJywKICBkaXZpZGVyOiAn5YiG5Ymy57q/JywgY291bnRkb3duOiAn5YCS6K6h5pe2JywKICBxcl9jb2RlOiAn5LqM57u056CBJywgcmVkZWU6ICfpooblj5bnpLzlk4EnLAp9CmZ1bmN0aW9uIGxlZEJsb2NrTGFiZWwodCkgeyByZXR1cm4gTEVEX0JMT0NLX0xBQkVMU1t0XSB8fCB0IH0KCmZ1bmN0aW9uIGFkZExlZEJsb2NrKHBhZ2UsIHR5cGUpIHsKICBjb25zdCBiID0geyBpZDogZ2VuSWQoJ2xiJyksIHR5cGUsIHByb3BzOiB7fSB9CiAgaWYgKHR5cGUgPT09ICdpbWFnZScpIGIucHJvcHMgPSB7IHVybDogJycsIGFsdDogJycsIGZ1bGxzY3JlZW46IGZhbHNlIH0KICBlbHNlIGlmICh0eXBlID09PSAndmlkZW8nKSBiLnByb3BzID0geyB1cmw6ICcnLCBhdXRvcGxheTogdHJ1ZSwgbG9vcDogdHJ1ZSB9CiAgZWxzZSBpZiAodHlwZSA9PT0gJ3RleHQnKSBiLnByb3BzID0geyBjb250ZW50OiAnJywgZm9udF9zaXplOiAnJywgY29sb3I6ICcnLCBhbGlnbjogJ2NlbnRlcicsIHdlaWdodDogJycsIG1hcmdpbjogJycgfQogIGVsc2UgaWYgKHR5cGUgPT09ICdyaWNoX3RleHQnKSBiLnByb3BzID0geyBodG1sOiAnJyB9CiAgZWxzZSBpZiAodHlwZSA9PT0gJ2NvdW50ZG93bicpIGIucHJvcHMgPSB7IGxhYmVsOiAnJywgZGVhZGxpbmU6ICcnIH0KICBlbHNlIGlmICh0eXBlID09PSAncXJfY29kZScpIGIucHJvcHMgPSB7IGltYWdlX3VybDogJycsIGxhYmVsOiAn5omr56CB5YWz5rOoIMK3IOmihuWPluagt+WTgScsIHNpemU6IDQ0MCB9CiAgZWxzZSBpZiAodHlwZSA9PT0gJ3JlZGVlbScpIGIucHJvcHMgPSB7CiAgICBjbGFpbV9idG5fdGV4dDogJ+eri+WNs+mihuWPluekvOWTgScsCiAgICBzaG93X2NvZGVfaW5wdXQ6IGZhbHNlLAogICAgY29kZV9sZW5ndGg6IDYsCiAgICBzaG93X3Byb2R1Y3RfZ3JpZDogdHJ1ZSwKICB9CiAgbGVkRm9ybS52YWx1ZVtwYWdlICsgJ19ibG9ja3MnXS5wdXNoKGIpCiAgZWRpdExlZEJsb2NrKHBhZ2UsIGxlZEZvcm0udmFsdWVbcGFnZSArICdfYmxvY2tzJ10ubGVuZ3RoIC0gMSkKfQoKZnVuY3Rpb24gZWRpdExlZEJsb2NrKHBhZ2UsIGkpIHsKICBlZGl0aW5nTGVkQmxvY2tQYWdlLnZhbHVlID0gcGFnZQogIGVkaXRpbmdMZWRCbG9ja0luZGV4LnZhbHVlID0gaQogIGNvbnN0IHNyYyA9IGxlZEZvcm0udmFsdWVbcGFnZSArICdfYmxvY2tzJ11baV0KICBPYmplY3QuYXNzaWduKGVkaXRpbmdMZWRCbG9jaywgeyBpZDogc3JjLmlkLCB0eXBlOiBzcmMudHlwZSwgcHJvcHM6IHsgLi4uc3JjLnByb3BzIH0gfSkKICBsZWRCbG9ja0RsZ1Zpc2libGUudmFsdWUgPSB0cnVlCn0KCmZ1bmN0aW9uIGNvbW1pdExlZEJsb2NrKCkgewogIGNvbnN0IHBhZ2UgPSBlZGl0aW5nTGVkQmxvY2tQYWdlLnZhbHVlCiAgY29uc3QgaSA9IGVkaXRpbmdMZWRCbG9ja0luZGV4LnZhbHVlCiAgaWYgKGkgPCAwKSByZXR1cm4KICBsZWRGb3JtLnZhbHVlW3BhZ2UgKyAnX2Jsb2NrcyddLnNwbGljZShpLCAxLCB7CiAgICBpZDogZWRpdGluZ0xlZEJsb2NrLmlkLAogICAgdHlwZTogZWRpdGluZ0xlZEJsb2NrLnR5cGUsCiAgICBwcm9wczogeyAuLi5lZGl0aW5nTGVkQmxvY2sucHJvcHMgfSwKICB9KQogIGxlZEJsb2NrRGxnVmlzaWJsZS52YWx1ZSA9IGZhbHNlCn0KCmZ1bmN0aW9uIHJlbW92ZUxlZEJsb2NrKHBhZ2UsIGkpIHsKICBFbE1lc3NhZ2VCb3guY29uZmlybSgn56Gu5a6a5Yig6Zmk5q2k5Yy65Z2X77yfJywgJ+ehruiupCcsIHsgdHlwZTogJ3dhcm5pbmcnIH0pCiAgICAudGhlbigoKSA9PiBsZWRGb3JtLnZhbHVlW3BhZ2UgKyAnX2Jsb2NrcyddLnNwbGljZShpLCAxKSkKICAgIC5jYXRjaCgoKSA9PiB7fSkKfQoKZnVuY3Rpb24gbW92ZUxlZEJsb2NrKHBhZ2UsIGksIGRlbHRhKSB7CiAgY29uc3QgaiA9IGkgKyBkZWx0YQogIGNvbnN0IGFyciA9IGxlZEZvcm0udmFsdWVbcGFnZSArICdfYmxvY2tzJ10KICBpZiAoaiA8IDAgfHwgaiA+PSBhcnIubGVuZ3RoKSByZXR1cm4KICA7W2FycltpXSwgYXJyW2pdXSA9IFthcnJbal0sIGFycltpXV0KfQoKLy8gYWQg57yW6L6RIGRpYWxvZwpjb25zdCBhZERsZ1Zpc2libGUgPSByZWYoZmFsc2UpCmNvbnN0IGVkaXRpbmdBZEluZGV4ID0gcmVmKC0xKQpjb25zdCBlZGl0aW5nQWQgPSByZWFjdGl2ZSh7CiAgdHlwZTogJ2ltYWdlJywgdXJsOiAnJywgZHVyYXRpb25fc2VjOiA4LAogIHNjaGVkdWxlOiB7CiAgICBlbmFibGVkOiBmYWxzZSwKICAgIGRheXNfb2Zfd2VlazogWzEsIDIsIDMsIDQsIDUsIDYsIDddLAogICAgX3N0YXJ0VGltZTogJycsIF9lbmRUaW1lOiAnJywKICAgIF9kYXRlUmFuZ2U6IG51bGwsCiAgfSwKfSkKCmZ1bmN0aW9uIF9kZWZhdWx0U2NoZWR1bGUoKSB7CiAgcmV0dXJuIHsKICAgIGVuYWJsZWQ6IGZhbHNlLAogICAgZGF5c19vZl93ZWVrOiBbMSwgMiwgMywgNCwgNSwgNiwgN10sCiAgICBzdGFydF90aW1lOiAnJywgZW5kX3RpbWU6ICcnLAogICAgc3RhcnRfZGF0ZTogJycsIGVuZF9kYXRlOiAnJywKICB9Cn0KCmZ1bmN0aW9uIGFkZEFkKHR5cGUpIHsKICBjb25zdCBhID0geyB0eXBlLCB1cmw6ICcnLCBkdXJhdGlvbl9zZWM6IDgsIHNjaGVkdWxlOiBfZGVmYXVsdFNjaGVkdWxlKCkgfQogIGxlZEZvcm0udmFsdWUuYWRzLnB1c2goYSkKICBlZGl0QWQobGVkRm9ybS52YWx1ZS5hZHMubGVuZ3RoIC0gMSkKfQpmdW5jdGlvbiBlZGl0QWQoaSkgewogIGVkaXRpbmdBZEluZGV4LnZhbHVlID0gaQogIGNvbnN0IHNyYyA9IGxlZEZvcm0udmFsdWUuYWRzW2ldCiAgY29uc3Qgc2NoZWQgPSBzcmMuc2NoZWR1bGUgfHwgX2RlZmF1bHRTY2hlZHVsZSgpCiAgT2JqZWN0LmFzc2lnbihlZGl0aW5nQWQsIHsKICAgIHR5cGU6IHNyYy50eXBlIHx8ICdpbWFnZScsCiAgICB1cmw6IHNyYy51cmwgfHwgJycsCiAgICBkdXJhdGlvbl9zZWM6IHNyYy5kdXJhdGlvbl9zZWMgfHwgOCwKICAgIHNjaGVkdWxlOiB7CiAgICAgIGVuYWJsZWQ6ICEhc2NoZWQuZW5hYmxlZCwKICAgICAgZGF5c19vZl93ZWVrOiBBcnJheS5pc0FycmF5KHNjaGVkLmRheXNfb2Zfd2VlaykgJiYgc2NoZWQuZGF5c19vZl93ZWVrLmxlbmd0aAogICAgICAgID8gWy4uLnNjaGVkLmRheXNfb2Zfd2Vla10KICAgICAgICA6IFsxLCAyLCAzLCA0LCA1LCA2LCA3XSwKICAgICAgX3N0YXJ0VGltZTogc2NoZWQuc3RhcnRfdGltZSB8fCAnJywKICAgICAgX2VuZFRpbWU6IHNjaGVkLmVuZF90aW1lIHx8ICcnLAogICAgICBfZGF0ZVJhbmdlOiAoc2NoZWQuc3RhcnRfZGF0ZSB8fCBzY2hlZC5lbmRfZGF0ZSkKICAgICAgICA/IFtzY2hlZC5zdGFydF9kYXRlIHx8ICcnLCBzY2hlZC5lbmRfZGF0ZSB8fCAnJ10gOiBudWxsLAogICAgfSwKICB9KQogIGFkRGxnVmlzaWJsZS52YWx1ZSA9IHRydWUKfQpmdW5jdGlvbiBjb21taXRBZCgpIHsKICBjb25zdCBpID0gZWRpdGluZ0FkSW5kZXgudmFsdWUKICBpZiAoaSA8IDApIHJldHVybgogIGNvbnN0IHNjaGVkID0gZWRpdGluZ0FkLnNjaGVkdWxlIHx8IHt9CiAgY29uc3QgcmFuZ2UgPSBzY2hlZC5fZGF0ZVJhbmdlIHx8IFtdCiAgbGVkRm9ybS52YWx1ZS5hZHMuc3BsaWNlKGksIDEsIHsKICAgIHR5cGU6IGVkaXRpbmdBZC50eXBlLAogICAgdXJsOiBlZGl0aW5nQWQudXJsLAogICAgZHVyYXRpb25fc2VjOiBlZGl0aW5nQWQuZHVyYXRpb25fc2VjLAogICAgc2NoZWR1bGU6IHsKICAgICAgZW5hYmxlZDogISFzY2hlZC5lbmFibGVkLAogICAgICBkYXlzX29mX3dlZWs6IHNjaGVkLmRheXNfb2Zfd2VlayB8fCBbMSwgMiwgMywgNCwgNSwgNiwgN10sCiAgICAgIHN0YXJ0X3RpbWU6IHNjaGVkLl9zdGFydFRpbWUgfHwgJycsCiAgICAgIGVuZF90aW1lOiBzY2hlZC5fZW5kVGltZSB8fCAnJywKICAgICAgc3RhcnRfZGF0ZTogcmFuZ2VbMF0gfHwgJycsCiAgICAgIGVuZF9kYXRlOiByYW5nZVsxXSB8fCAnJywKICAgIH0sCiAgfSkKICBhZERsZ1Zpc2libGUudmFsdWUgPSBmYWxzZQp9CmZ1bmN0aW9uIHJlbW92ZUFkKGkpIHsKICBFbE1lc3NhZ2VCb3guY29uZmlybSgn56Gu5a6a5Yig6Zmk5q2k57Sg5p2Q77yfJywgJ+ehruiupCcsIHsgdHlwZTogJ3dhcm5pbmcnIH0pCiAgICAudGhlbigoKSA9PiBsZWRGb3JtLnZhbHVlLmFkcy5zcGxpY2UoaSwgMSkpCiAgICAuY2F0Y2goKCkgPT4ge30pCn0KZnVuY3Rpb24gbW92ZUFkKGksIGRlbHRhKSB7CiAgY29uc3QgaiA9IGkgKyBkZWx0YQogIGlmIChqIDwgMCB8fCBqID49IGxlZEZvcm0udmFsdWUuYWRzLmxlbmd0aCkgcmV0dXJuCiAgY29uc3QgYXJyID0gbGVkRm9ybS52YWx1ZS5hZHMKICA7W2FycltpXSwgYXJyW2pdXSA9IFthcnJbal0sIGFycltpXV0KfQoKZnVuY3Rpb24gc2NoZWR1bGVTdW1tYXJ5KHMpIHsKICBpZiAoIXM/LmVuYWJsZWQpIHJldHVybiAnJwogIGNvbnN0IHBhcnRzID0gW10KICBpZiAocy5kYXlzX29mX3dlZWsgJiYgcy5kYXlzX29mX3dlZWsubGVuZ3RoICYmIHMuZGF5c19vZl93ZWVrLmxlbmd0aCA8IDcpIHsKICAgIGNvbnN0IE5BTUVTID0gWycnLCAn5LiAJywgJ+S6jCcsICfkuIknLCAn5ZubJywgJ+S6lCcsICflha0nLCAn5pelJ10KICAgIHBhcnRzLnB1c2goJ+WRqCcgKyBzLmRheXNfb2Zfd2Vlay5tYXAoZCA9PiBOQU1FU1tkXSB8fCAnPycpLmpvaW4oJywnKSkKICB9CiAgaWYgKHMuc3RhcnRfdGltZSB8fCBzLmVuZF90aW1lKSBwYXJ0cy5wdXNoKGAke3Muc3RhcnRfdGltZSB8fCAnMDA6MDAnfS0ke3MuZW5kX3RpbWUgfHwgJzIzOjU5J31gKQogIGlmIChzLnN0YXJ0X2RhdGUgfHwgcy5lbmRfZGF0ZSkgcGFydHMucHVzaChgJHtzLnN0YXJ0X2RhdGUgfHwgJ34nfSB+ICR7cy5lbmRfZGF0ZSB8fCAnfid9YCkKICByZXR1cm4gcGFydHMubGVuZ3RoID8gcGFydHMuam9pbignIMK3ICcpIDogJ+WFqOWkqScKfQoKLy8gPT09PT09PT09PT09IOS9jee9ruWPmOabtCDihpIg5a6e5pe25o6o6YCB5Yiw6aKE6KeIIGlmcmFtZSA9PT09PT09PT09PT0KbGV0IHBvc1RpbWVyID0gbnVsbApmdW5jdGlvbiBwdXNoUG9zaXRpb25Ub0lmcmFtZShmaWVsZCwgcG9zaXRpb24pIHsKICBjb25zdCBpZnJhbWUgPSBwcmV2aWV3SWZyYW1lLnZhbHVlCiAgaWYgKCFpZnJhbWUgfHwgIWlmcmFtZS5jb250ZW50V2luZG93KSByZXR1cm4KICBpZnJhbWUuY29udGVudFdpbmRvdy5wb3N0TWVzc2FnZSh7CiAgICB0eXBlOiAnZ3VzaC1wb3NpdGlvbi1zZXQnLAogICAgZmllbGQsCiAgICBwb3NpdGlvbiwKICB9LCAnKicpCn0Kd2F0Y2goKCkgPT4gW2g1Rm9ybS52YWx1ZS5oZWFkZXJfcG9zaXRpb24/LngsIGg1Rm9ybS52YWx1ZS5oZWFkZXJfcG9zaXRpb24/LnldLCAoKSA9PiB7CiAgY2xlYXJUaW1lb3V0KHBvc1RpbWVyKQogIHBvc1RpbWVyID0gc2V0VGltZW91dCgoKSA9PiB7CiAgICBwdXNoUG9zaXRpb25Ub0lmcmFtZSgnaGVhZGVyX3Bvc2l0aW9uJywgaDVGb3JtLnZhbHVlLmhlYWRlcl9wb3NpdGlvbikKICB9LCAxMDApCn0pCndhdGNoKCgpID0+IFtoNUZvcm0udmFsdWUuYnV0dG9uX3Bvc2l0aW9uPy54LCBoNUZvcm0udmFsdWUuYnV0dG9uX3Bvc2l0aW9uPy55XSwgKCkgPT4gewogIGNsZWFyVGltZW91dChwb3NUaW1lcikKICBwb3NUaW1lciA9IHNldFRpbWVvdXQoKCkgPT4gewogICAgcHVzaFBvc2l0aW9uVG9JZnJhbWUoJ2J1dHRvbl9wb3NpdGlvbicsIGg1Rm9ybS52YWx1ZS5idXR0b25fcG9zaXRpb24pCiAgfSwgMTAwKQp9KQoKLy8gPT09PT09PT09PT09IGlmcmFtZSDpooTop4ggPT09PT09PT09PT09CmNvbnN0IHByZXZpZXdJZnJhbWUgPSByZWYobnVsbCkKY29uc3QgaDVQcmV2aWV3TW9kZSA9IHJlZigicGhvbmUiKQpjb25zdCBoNVByZXZpZXdGdWxsID0gcmVmKGZhbHNlKQpjb25zdCBwcmV2aWV3QnVzdCA9IHJlZihEYXRlLm5vdygpKQpmdW5jdGlvbiByZWZyZXNoUHJldmlldygpIHsgcHJldmlld0J1c3QudmFsdWUgPSBEYXRlLm5vdygpIH0KCi8vID09PT09PT09PT09PSBibG9ja3Mg57yW6L6RID09PT09PT09PT09PQpjb25zdCBibG9ja0RsZ1Zpc2libGUgPSByZWYoZmFsc2UpCmNvbnN0IGVkaXRpbmdCbG9ja0luZGV4ID0gcmVmKC0xKQpjb25zdCBlZGl0aW5nQmxvY2sgPSByZWFjdGl2ZSh7IGlkOiAnJywgdHlwZTogJ3RleHQnLCBwcm9wczoge30gfSkKCmNvbnN0IEJMT0NLX0xBQkVMUyA9IHsKICBoZWFkZXI6ICfpobXpnaLlpLTpg6gnLCBpbWFnZTogJ+WbvueJhycsIHZpZGVvOiAn6KeG6aKRJywgdGV4dDogJ+aWh+acrCcsIHJpY2hfdGV4dDogJ+WvjOaWh+acrCcsCiAgZGl2aWRlcjogJ+WIhuWJsue6vycsIGNvdW50ZG93bjogJ+WAkuiuoeaXticsCiAgZm9ybTogJ+ihqOWNlSjlkKvlrZfmrrUpJywgcHJpdmFjeTogJ+makOengeWjsOaYjicsIHN1Y2Nlc3M6ICfmiJDlip/op4blm74nLAp9CmZ1bmN0aW9uIGJsb2NrTGFiZWwodCkgeyByZXR1cm4gQkxPQ0tfTEFCRUxTW3RdIHx8IHQgfQpmdW5jdGlvbiBibG9ja1N1bW1hcnkoYikgewogIGNvbnN0IHAgPSBiLnByb3BzIHx8IHt9CiAgaWYgKGIudHlwZSA9PT0gJ2hlYWRlcicpIHJldHVybiBwLnRpdGxlIHx8ICco6aG16Z2i5aS06YOoKScKICBpZiAoYi50eXBlID09PSAnaW1hZ2UnIHx8IGIudHlwZSA9PT0gJ3ZpZGVvJykgcmV0dXJuIHAudXJsIHx8ICco5pyq6YWN572uIFVSTCknCiAgaWYgKGIudHlwZSA9PT0gJ3RleHQnKSByZXR1cm4gKHAuY29udGVudCB8fCAnKOepuiknKS5zbGljZSgwLCA0MCkKICBpZiAoYi50eXBlID09PSAncmljaF90ZXh0JykgcmV0dXJuIChwLmh0bWwgfHwgJyjnqbopJykucmVwbGFjZSgvPFtePl0rPi9nLCAnJykuc2xpY2UoMCwgNDApCiAgaWYgKGIudHlwZSA9PT0gJ2NvdW50ZG93bicpIHJldHVybiBwLmxhYmVsIHx8ICco5YCS6K6h5pe2KScKICBpZiAoYi50eXBlID09PSAnZm9ybScpIHJldHVybiBgJHtwLmZpZWxkcz8ubGVuZ3RoIHx8IDB9IOS4quWtl+autSwg5oyJ6ZKuOiAiJHtwLnN1Ym1pdF9idXR0b24/LnRleHQgfHwgJ+mihuWPlid9ImAKICBpZiAoYi50eXBlID09PSAncHJpdmFjeScpIHJldHVybiBwLmVuYWJsZWQgIT09IGZhbHNlID8gcC50ZXh0IHx8ICco6ZqQ56eB5aOw5piOKScgOiAnKOacquWQr+eUqCknCiAgaWYgKGIudHlwZSA9PT0gJ3N1Y2Nlc3MnKSByZXR1cm4gYCR7cC50aXRsZSB8fCAnJ30gJHtwLmNvZGVfbGFiZWwgfHwgJyd9YAogIGlmIChiLnR5cGUgPT09ICdxcl9jb2RlJykgcmV0dXJuIChwLmxhYmVsIHx8ICco5LqM57u056CBKScpICsgKHAuaW1hZ2VfdXJsID8gJyDinIUnIDogJyDinYwnKQogIGlmIChiLnR5cGUgPT09ICdyZWRlZW0nKSByZXR1cm4gcC5jbGFpbV9idG5fdGV4dCB8fCAnKOmihuWPluekvOWTgSknCiAgcmV0dXJuICcnCn0KZnVuY3Rpb24gZ2VuSWQocHJlZml4KSB7IHJldHVybiBwcmVmaXggKyAnXycgKyBNYXRoLnJhbmRvbSgpLnRvU3RyaW5nKDM2KS5zbGljZSgyLCA4KSB9CmZ1bmN0aW9uIGFkZEJsb2NrKHR5cGUpIHsKICBjb25zdCBiID0geyBpZDogZ2VuSWQoJ2InKSwgdHlwZSwgcHJvcHM6IHt9IH0KICBpZiAodHlwZSA9PT0gJ2hlYWRlcicpIGIucHJvcHMgPSB7IHRpdGxlOiAnJywgc3VidGl0bGU6ICcnIH0KICBlbHNlIGlmICh0eXBlID09PSAnaW1hZ2UnKSBiLnByb3BzID0geyB1cmw6ICcnLCBhbHQ6ICcnIH0KICBlbHNlIGlmICh0eXBlID09PSAndmlkZW8nKSBiLnByb3BzID0geyB1cmw6ICcnLCBhdXRvcGxheTogZmFsc2UsIGxvb3A6IGZhbHNlIH0KICBlbHNlIGlmICh0eXBlID09PSAndGV4dCcpIGIucHJvcHMgPSB7IGNvbnRlbnQ6ICcnLCBmb250X3NpemU6ICcnLCBjb2xvcjogJycsIGFsaWduOiAnY2VudGVyJywgd2VpZ2h0OiAnJywgbWFyZ2luOiAnJyB9CiAgZWxzZSBpZiAodHlwZSA9PT0gJ3JpY2hfdGV4dCcpIGIucHJvcHMgPSB7IGh0bWw6ICcnIH0KICBlbHNlIGlmICh0eXBlID09PSAnY291bnRkb3duJykgYi5wcm9wcyA9IHsgbGFiZWw6ICcnLCBkZWFkbGluZTogJycgfQogIGVsc2UgaWYgKHR5cGUgPT09ICdmb3JtJykgYi5wcm9wcyA9IHsgZmllbGRzOiBbXSwgc3VibWl0X2J1dHRvbjogeyB0ZXh0OiAn56uL5Y2z6aKG5Y+WJywgY29sb3I6ICcnIH0sIHJhdGVfbGltaXQ6ICdwZXJfZGV2aWNlX2RheScgfQogIGVsc2UgaWYgKHR5cGUgPT09ICdwcml2YWN5JykgYi5wcm9wcyA9IHsgZW5hYmxlZDogdHJ1ZSwgdGV4dDogJ+aIkeW3sumYheivu+W5tuWQjOaEj+OAiumakOengeWNj+iuruOAiycsIHVybDogJycgfQogIGVsc2UgaWYgKHR5cGUgPT09ICdzdWNjZXNzJykgYi5wcm9wcyA9IHsgdGl0bGU6ICfpooblj5bmiJDlip8nLCBzdWJ0aXRsZTogJ+avj+S4quiuvuWkh+avj+WkqeWPquiDvemihuWPluS4gOasoScsIGNvZGVfbGFiZWw6ICfmgqjnmoTlhZHmjaLnoIEnLCBmb290ZXJfdGlwOiAn6K+35Zyo57uI56uv6aG16Z2i6L6T5YWl5q2k56CB6L+b6KGM5qC46ZSAJyB9CiAgaDVGb3JtLnZhbHVlLmJsb2Nrcy5wdXNoKGIpCiAgZWRpdEJsb2NrKGg1Rm9ybS52YWx1ZS5ibG9ja3MubGVuZ3RoIC0gMSkKfQpmdW5jdGlvbiBlZGl0QmxvY2soaSkgewogIGVkaXRpbmdCbG9ja0luZGV4LnZhbHVlID0gaQogIGNvbnN0IHNyYyA9IGg1Rm9ybS52YWx1ZS5ibG9ja3NbaV0KICBPYmplY3QuYXNzaWduKGVkaXRpbmdCbG9jaywgeyBpZDogc3JjLmlkLCB0eXBlOiBzcmMudHlwZSwgcHJvcHM6IHsgLi4uc3JjLnByb3BzIH0gfSkKICBibG9ja0RsZ1Zpc2libGUudmFsdWUgPSB0cnVlCn0KZnVuY3Rpb24gY29tbWl0QmxvY2soKSB7CiAgY29uc3QgaSA9IGVkaXRpbmdCbG9ja0luZGV4LnZhbHVlCiAgaWYgKGkgPCAwKSByZXR1cm4KICBoNUZvcm0udmFsdWUuYmxvY2tzLnNwbGljZShpLCAxLCB7CiAgICBpZDogZWRpdGluZ0Jsb2NrLmlkLAogICAgdHlwZTogZWRpdGluZ0Jsb2NrLnR5cGUsCiAgICBwcm9wczogeyAuLi5lZGl0aW5nQmxvY2sucHJvcHMgfQogIH0pCiAgYmxvY2tEbGdWaXNpYmxlLnZhbHVlID0gZmFsc2UKfQpmdW5jdGlvbiByZW1vdmVCbG9jayhpKSB7CiAgRWxNZXNzYWdlQm94LmNvbmZpcm0oJ+ehruWumuWIoOmZpOatpOWMuuWdl++8nycsICfnoa7orqQnLCB7IHR5cGU6ICd3YXJuaW5nJyB9KQogICAgLnRoZW4oKCkgPT4gaDVGb3JtLnZhbHVlLmJsb2Nrcy5zcGxpY2UoaSwgMSkpCiAgICAuY2F0Y2goKCkgPT4ge30pCn0KYXN5bmMgZnVuY3Rpb24gbW92ZUJsb2NrKGksIGRlbHRhKSB7CiAgY29uc3QgaiA9IGkgKyBkZWx0YQogIGlmIChqIDwgMCB8fCBqID49IGg1Rm9ybS52YWx1ZS5ibG9ja3MubGVuZ3RoKSByZXR1cm4KICBjb25zdCBhcnIgPSBoNUZvcm0udmFsdWUuYmxvY2tzCiAgO1thcnJbaV0sIGFycltqXV0gPSBbYXJyW2pdLCBhcnJbaV1dCiAgaWYgKGFjdGl2ZVRhYi52YWx1ZSA9PT0gJ2g1JyAmJiAhdmFyaWFudEVkaXRpbmcudmFsdWUpIGF3YWl0IHNhdmVINV9TaWxlbnQoKQogIGVsc2UgaWYgKGFjdGl2ZVRhYi52YWx1ZSA9PT0gJ2xlZCcpIGF3YWl0IHNhdmVMZWRfU2lsZW50KCkKfQovLyDmi5bmi73mjpLluo/vvJrlsIYgYXJyW2Zyb21dIOenu+WKqOWIsCBhcnJbdG9dCmZ1bmN0aW9uIG1vdmVUbyhhcnIsIGZyb20sIHRvKSB7CiAgaWYgKGZyb20gPCAwIHx8IGZyb20gPT09IHRvKSByZXR1cm4KICBjb25zdCB0YXJnZXQgPSB0byA+IGZyb20gPyB0byAtIDEgOiB0bwogIGNvbnN0IFtpdGVtXSA9IGFyci5zcGxpY2UoZnJvbSwgMSkKICBhcnIuc3BsaWNlKHRhcmdldCwgMCwgaXRlbSkKICBuZXh0VGljayhhc3luYyAoKSA9PiB7CiAgICBpZiAoYWN0aXZlVGFiLnZhbHVlID09PSAnaDUnICYmICF2YXJpYW50RWRpdGluZy52YWx1ZSkgYXdhaXQgc2F2ZUg1X1NpbGVudCgpCiAgICBlbHNlIGlmIChhY3RpdmVUYWIudmFsdWUgPT09ICdsZWQnKSBhd2FpdCBzYXZlTGVkX1NpbGVudCgpCiAgfSkKfQpmdW5jdGlvbiBtb3ZlVG9MZWQoYXJyLCBmcm9tLCB0bykgewogIGlmIChmcm9tIDwgMCB8fCBmcm9tID09PSB0bykgcmV0dXJuCiAgY29uc3QgdGFyZ2V0ID0gdG8gPiBmcm9tID8gdG8gLSAxIDogdG8KICBjb25zdCBbaXRlbV0gPSBhcnIuc3BsaWNlKGZyb20sIDEpCiAgYXJyLnNwbGljZSh0YXJnZXQsIDAsIGl0ZW0pCiAgbmV4dFRpY2soYXN5bmMgKCkgPT4gewogICAgaWYgKGFjdGl2ZVRhYi52YWx1ZSA9PT0gJ2xlZCcpIGF3YWl0IHNhdmVMZWRfU2lsZW50KCkKICB9KQp9CmZ1bmN0aW9uIGFkZEZvcm1GaWVsZCgpIHsKICBlZGl0aW5nRmllbGRCbG9ja0lkLnZhbHVlID0gZWRpdGluZ0Jsb2NrLmlkICAvLyB0aGUgYmxvY2sgY3VycmVudGx5IGJlaW5nIGVkaXRlZCBpbiB0aGUgZGlhbG9nCiAgY29uc3QgZiA9IHsKICAgIGtleTogZ2VuSWQoJ2YnKSwKICAgIGxhYmVsOiAn5paw5a2X5q61JywKICAgIHR5cGU6ICd0ZXh0JywKICAgIHJlcXVpcmVkOiBmYWxzZSwKICAgIHBsYWNlaG9sZGVyOiAnJywKICAgIHZhbGlkYXRlX3JlZ2V4OiAnJywKICAgIGVycm9yX21zZzogJycsCiAgICBvcHRpb25zOiBbXQogIH0KICBlZGl0aW5nQmxvY2sucHJvcHMuZmllbGRzLnB1c2goZikKICBlZGl0Rm9ybUZpZWxkSW5saW5lKGVkaXRpbmdCbG9jay5wcm9wcy5maWVsZHMubGVuZ3RoIC0gMSkKfQpmdW5jdGlvbiBlZGl0Rm9ybUZpZWxkKGkpIHsKICBlZGl0aW5nRmllbGRCbG9ja0lkLnZhbHVlID0gZWRpdGluZ0Jsb2NrLmlkCiAgZWRpdEZvcm1GaWVsZElubGluZShpKQp9CmZ1bmN0aW9uIGVkaXRGb3JtRmllbGRJbmxpbmUoaSkgewogIGVkaXRpbmdGaWVsZEluZGV4LnZhbHVlID0gaQogIGNvbnN0IHNyYyA9IGVkaXRpbmdCbG9jay5wcm9wcy5maWVsZHNbaV0KICBPYmplY3QuYXNzaWduKGVkaXRpbmdGaWVsZCwgewogICAga2V5OiBzcmMua2V5IHx8ICcnLAogICAgbGFiZWw6IHNyYy5sYWJlbCB8fCAnJywKICAgIHR5cGU6IHNyYy50eXBlIHx8ICd0ZXh0JywKICAgIHJlcXVpcmVkOiAhIXNyYy5yZXF1aXJlZCwKICAgIHBsYWNlaG9sZGVyOiBzcmMucGxhY2Vob2xkZXIgfHwgJycsCiAgICB2YWxpZGF0ZV9yZWdleDogc3JjLnZhbGlkYXRlX3JlZ2V4IHx8ICcnLAogICAgZXJyb3JfbXNnOiBzcmMuZXJyb3JfbXNnIHx8ICcnLAogICAgb3B0aW9uczogSlNPTi5wYXJzZShKU09OLnN0cmluZ2lmeShzcmMub3B0aW9ucyB8fCBbXSkpCiAgfSkKICBmaWVsZERsZ1Zpc2libGUudmFsdWUgPSB0cnVlCn0KCi8vID09PT09PT09PT09PSBmb3JtIGZpZWxkcyDnvJbovpEgPT09PT09PT09PT09CmNvbnN0IGZpZWxkRGxnVmlzaWJsZSA9IHJlZihmYWxzZSkKY29uc3QgZWRpdGluZ0ZpZWxkSW5kZXggPSByZWYoLTEpCmNvbnN0IGVkaXRpbmdGaWVsZEJsb2NrSWQgPSByZWYoJycpICAvLyBmb3JtIOWMuuWdl+eahCBmaWVsZCDnvJbovpHvvJrorrDlvZXmiYDlsZ4gYmxvY2sgaWQKY29uc3QgZWRpdGluZ0ZpZWxkID0gcmVhY3RpdmUoewogIGtleTogJycsIGxhYmVsOiAnJywgdHlwZTogJ3RleHQnLCByZXF1aXJlZDogZmFsc2UsCiAgcGxhY2Vob2xkZXI6ICcnLCB2YWxpZGF0ZV9yZWdleDogJycsIGVycm9yX21zZzogJycsIG9wdGlvbnM6IFtdCn0pCgpjb25zdCBGSUVMRF9MQUJFTFMgPSB7CiAgdGV4dDogJ+aWh+acrCcsIHRlbDogJ+aJi+acuuWPtycsIHJhZGlvOiAn5Y2V6YCJJywgc2VsZWN0OiAn5LiL5ouJJywgY2hlY2tib3g6ICfli77pgIknLCBtdWx0aXNlbGVjdDogJ+WkmumAiScsIGdlbmRlcjogJ+aAp+WIqycsIG5hbWU6ICflp5PlkI0nLCBhZ2U6ICflubTpvoQnCn0KZnVuY3Rpb24gZmllbGRMYWJlbCh0KSB7IHJldHVybiBGSUVMRF9MQUJFTFNbdF0gfHwgdCB9CgpmdW5jdGlvbiBhZGRGaWVsZCh0eXBlKSB7CiAgY29uc3QgZiA9IHsKICAgIGtleTogZ2VuSWQoJ2YnKSwKICAgIGxhYmVsOiAn5paw5a2X5q61JywKICAgIHR5cGUsCiAgICByZXF1aXJlZDogZmFsc2UsCiAgICBwbGFjZWhvbGRlcjogJycsCiAgICB2YWxpZGF0ZV9yZWdleDogdHlwZSA9PT0gJ3RlbCcgPyAnXjFbMy05XVxcZHs5fSQnIDogJycsCiAgICBlcnJvcl9tc2c6IHR5cGUgPT09ICd0ZWwnID8gJ+ivt+Whq+WGmeato+ehrueahOaJi+acuuWPtycgOiAnJywKICAgIG9wdGlvbnM6IFsncmFkaW8nLCdzZWxlY3QnLCdnZW5kZXInLCdtdWx0aXNlbGVjdCddLmluY2x1ZGVzKHR5cGUpID8gW3sgdmFsdWU6ICdvcHQxJywgbGFiZWw6ICfpgInpobnkuIAnLCBzdWJsYWJlbDogJycsIGljb246ICcnIH1dIDogW10KICB9CiAgLy8gZ2VuZGVyIOaAp+WIq+Wtl+auteiHquWKqOWhq+WFheeUt+Wls+mAiemhuQogIGlmICh0eXBlID09PSAnZ2VuZGVyJykgewogICAgZi5sYWJlbCA9ICfmgKfliKsnCiAgICBmLm9wdGlvbnMgPSBbCiAgICAgIHsgdmFsdWU6ICdtYWxlJywgbGFiZWw6ICfnlLcnLCBzdWJsYWJlbDogJycsIGljb246ICcnIH0sCiAgICAgIHsgdmFsdWU6ICdmZW1hbGUnLCBsYWJlbDogJ+WlsycsIHN1YmxhYmVsOiAnJywgaWNvbjogJycgfQogICAgXQogIH0KICBpZiAodHlwZSA9PT0gJ25hbWUnKSB7CiAgICBmLmxhYmVsID0gJ+Wnk+WQjScKICAgIGYucGxhY2Vob2xkZXIgPSAn6K+36L6T5YWl5aeT5ZCNJwogIH0KICBpZiAodHlwZSA9PT0gJ2FnZScpIHsKICAgIGYubGFiZWwgPSAn5bm06b6EJwogICAgZi5wbGFjZWhvbGRlciA9ICfor7fovpPlhaXlubTpvoQnCiAgICBmLnZhbGlkYXRlX3JlZ2V4ID0gJ15cXGQrJCcKICAgIGYuZXJyb3JfbXNnID0gJ+ivt+i+k+WFpeato+ehrueahOW5tOm+hCcKICB9CiAgaDVGb3JtLnZhbHVlLmZvcm1fZmllbGRzLnB1c2goZikKICBlZGl0RmllbGQoaDVGb3JtLnZhbHVlLmZvcm1fZmllbGRzLmxlbmd0aCAtIDEpCn0KZnVuY3Rpb24gZWRpdEZpZWxkKGkpIHsKICBlZGl0aW5nRmllbGRJbmRleC52YWx1ZSA9IGkKICBjb25zdCBzcmMgPSBoNUZvcm0udmFsdWUuZm9ybV9maWVsZHNbaV0KICBPYmplY3QuYXNzaWduKGVkaXRpbmdGaWVsZCwgewogICAga2V5OiBzcmMua2V5IHx8ICcnLAogICAgbGFiZWw6IHNyYy5sYWJlbCB8fCAnJywKICAgIHR5cGU6IHNyYy50eXBlIHx8ICd0ZXh0JywKICAgIHJlcXVpcmVkOiAhIXNyYy5yZXF1aXJlZCwKICAgIHBsYWNlaG9sZGVyOiBzcmMucGxhY2Vob2xkZXIgfHwgJycsCiAgICB2YWxpZGF0ZV9yZWdleDogc3JjLnZhbGlkYXRlX3JlZ2V4IHx8ICcnLAogICAgZXJyb3JfbXNnOiBzcmMuZXJyb3JfbXNnIHx8ICcnLAogICAgb3B0aW9uczogSlNPTi5wYXJzZShKU09OLnN0cmluZ2lmeShzcmMub3B0aW9ucyB8fCBbXSkpCiAgfSkKICBmaWVsZERsZ1Zpc2libGUudmFsdWUgPSB0cnVlCn0KZnVuY3Rpb24gY29tbWl0RmllbGQoKSB7CiAgaWYgKCFlZGl0aW5nRmllbGQua2V5LnRyaW0oKSkgewogICAgRWxNZXNzYWdlLmVycm9yKCflrZfmrrUga2V5IOS4jeiDveS4uuepuicpCiAgICByZXR1cm4KICB9CiAgY29uc3QgaSA9IGVkaXRpbmdGaWVsZEluZGV4LnZhbHVlCiAgaWYgKGkgPCAwKSByZXR1cm4KICBjb25zdCBwYXlsb2FkID0gewogICAga2V5OiBlZGl0aW5nRmllbGQua2V5LnRyaW0oKSwKICAgIGxhYmVsOiBlZGl0aW5nRmllbGQubGFiZWwsCiAgICB0eXBlOiBlZGl0aW5nRmllbGQudHlwZSwKICAgIHJlcXVpcmVkOiBlZGl0aW5nRmllbGQucmVxdWlyZWQsCiAgfQogIGlmIChlZGl0aW5nRmllbGQucGxhY2Vob2xkZXIpIHBheWxvYWQucGxhY2Vob2xkZXIgPSBlZGl0aW5nRmllbGQucGxhY2Vob2xkZXIKICBpZiAoZWRpdGluZ0ZpZWxkLnZhbGlkYXRlX3JlZ2V4KSBwYXlsb2FkLnZhbGlkYXRlX3JlZ2V4ID0gZWRpdGluZ0ZpZWxkLnZhbGlkYXRlX3JlZ2V4CiAgaWYgKGVkaXRpbmdGaWVsZC5lcnJvcl9tc2cpIHBheWxvYWQuZXJyb3JfbXNnID0gZWRpdGluZ0ZpZWxkLmVycm9yX21zZwogIGlmIChbJ3JhZGlvJywnc2VsZWN0JywnZ2VuZGVyJywnbXVsdGlzZWxlY3QnXS5pbmNsdWRlcyhlZGl0aW5nRmllbGQudHlwZSkpIHsKICAgIHBheWxvYWQub3B0aW9ucyA9IEpTT04ucGFyc2UoSlNPTi5zdHJpbmdpZnkoZWRpdGluZ0ZpZWxkLm9wdGlvbnMpKQogIH0KICAvLyDlpoLmnpzmmK8gZm9ybSDljLrlnZflhoXnmoQgZmllbGQg57yW6L6R77yM5YaZ5ZueIGJsb2NrLnByb3BzLmZpZWxkcwogIGlmIChlZGl0aW5nRmllbGRCbG9ja0lkLnZhbHVlKSB7CiAgICBjb25zdCBibG9jayA9IGg1Rm9ybS52YWx1ZS5ibG9ja3MuZmluZChiID0+IGIuaWQgPT09IGVkaXRpbmdGaWVsZEJsb2NrSWQudmFsdWUpCiAgICBpZiAoYmxvY2sgJiYgYmxvY2sucHJvcHMuZmllbGRzKSB7CiAgICAgIGJsb2NrLnByb3BzLmZpZWxkcy5zcGxpY2UoaSwgMSwgcGF5bG9hZCkKICAgIH0KICB9IGVsc2UgewogICAgaDVGb3JtLnZhbHVlLmZvcm1fZmllbGRzLnNwbGljZShpLCAxLCBwYXlsb2FkKQogIH0KICBlZGl0aW5nRmllbGRCbG9ja0lkLnZhbHVlID0gJycKICBmaWVsZERsZ1Zpc2libGUudmFsdWUgPSBmYWxzZQp9CmZ1bmN0aW9uIHJlbW92ZUZpZWxkKGkpIHsKICBFbE1lc3NhZ2VCb3guY29uZmlybSgn56Gu5a6a5Yig6Zmk5q2k5a2X5q6177yfJywgJ+ehruiupCcsIHsgdHlwZTogJ3dhcm5pbmcnIH0pCiAgICAudGhlbigoKSA9PiBoNUZvcm0udmFsdWUuZm9ybV9maWVsZHMuc3BsaWNlKGksIDEpKQogICAgLmNhdGNoKCgpID0+IHt9KQp9CmZ1bmN0aW9uIG1vdmVGaWVsZChpLCBkZWx0YSkgewogIGNvbnN0IGogPSBpICsgZGVsdGEKICBpZiAoaiA8IDAgfHwgaiA+PSBoNUZvcm0udmFsdWUuZm9ybV9maWVsZHMubGVuZ3RoKSByZXR1cm4KICBjb25zdCBhcnIgPSBoNUZvcm0udmFsdWUuZm9ybV9maWVsZHMKICA7W2FycltpXSwgYXJyW2pdXSA9IFthcnJbal0sIGFycltpXV0KfQoKY29uc3QgZm9udFByZXNldHMgPSBbCiAgeyBsYWJlbDogJ+aAnea6kOm7keS9k++8iOm7mOiupO+8iScsIHZhbHVlOiAnIk5vdG8gU2FucyBTQyIsIC1hcHBsZS1zeXN0ZW0sIHNhbnMtc2VyaWYnIH0sCiAgeyBsYWJlbDogJ+iLueaWuScsIHZhbHVlOiAnIlBpbmdGYW5nIFNDIiwgLWFwcGxlLXN5c3RlbSwgc2Fucy1zZXJpZicgfSwKICB7IGxhYmVsOiAn5b6u6L2v6ZuF6buRJywgdmFsdWU6ICciTWljcm9zb2Z0IFlhSGVpIiwgc2Fucy1zZXJpZicgfSwKICB7IGxhYmVsOiAn5a6L5L2TJywgdmFsdWU6ICdTaW1TdW4sICJTb25ndGkgU0MiLCBzZXJpZicgfSwKICB7IGxhYmVsOiAn57O757uf6buY6K6kJywgdmFsdWU6ICctYXBwbGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsIHNhbnMtc2VyaWYnIH0KXQoKY29uc3QgcHJldmlld0JnU3R5bGUgPSBjb21wdXRlZCgoKSA9PiB7CiAgY29uc3QgdCA9IHRoZW1lRm9ybS52YWx1ZQogIGlmICh0LmJhY2tncm91bmRfdHlwZSA9PT0gJ2ltYWdlJyAmJiB0aGVtZS52YWx1ZT8uYmFja2dyb3VuZF9pbWFnZV91cmwpIHsKICAgIHJldHVybiB7IGJhY2tncm91bmQ6IGB1cmwoJHt0aGVtZS52YWx1ZS5iYWNrZ3JvdW5kX2ltYWdlX3VybH0pIGNlbnRlci9jb3ZlciwgJHt0LmFjY2VudF9jb2xvcn1gIH0KICB9CiAgaWYgKHQuYmFja2dyb3VuZF90eXBlID09PSAnZ3JhZGllbnQnKSB7CiAgICByZXR1cm4geyBiYWNrZ3JvdW5kOiB0LmJhY2tncm91bmRfdmFsdWUgfHwgJ2xpbmVhci1ncmFkaWVudCgxMzVkZWcsIzBhMGEwYSwjMWExYTFhKScgfQogIH0KICByZXR1cm4geyBiYWNrZ3JvdW5kOiB0LmJhY2tncm91bmRfdmFsdWUgfHwgJyMwYTBhMGEnIH0KfSkKCi8vID09PT09PT09PT09PSDliqDovb0gPT09PT09PT09PT09CmFzeW5jIGZ1bmN0aW9uIGxvYWRBbGwoKSB7CiAgbG9hZGluZy52YWx1ZSA9IHRydWUKICB0cnkgewogICAgY29uc3QgW3AsIHQsIGgsIGwsIHZdID0gYXdhaXQgUHJvbWlzZS5hbGwoWwogICAgICBnZXRQcm9qZWN0KHByb2plY3RJZCksCiAgICAgIGdldFByb2plY3RUaGVtZShwcm9qZWN0SWQpLAogICAgICBnZXRQcm9qZWN0SDUocHJvamVjdElkKSwKICAgICAgZ2V0UHJvamVjdExlZChwcm9qZWN0SWQpLAogICAgICBsaXN0UGFnZVZlcnNpb25zKHByb2plY3RJZCkKICAgIF0pCiAgICBwcm9qZWN0LnZhbHVlID0gcAogICAgdGhlbWUudmFsdWUgPSB0CiAgICBoNS52YWx1ZSA9IGgKICAgIGxlZC52YWx1ZSA9IGwKICAgIHZlcnNpb25zLnZhbHVlID0gdgogICAgc3luY1RoZW1lRm9ybSh0KQogICAgc3luY0g1Rm9ybShoKQogICAgc3luY0xlZEZvcm0obCkKICAgIC8vIOm7mOiupOmAieesrOS4gOWPsOe7keWumueahOiuvuWkh+WBmumihOiniAogICAgaWYgKCFwcmV2aWV3TWFjaGluZUlkLnZhbHVlICYmIHAubWFjaGluZXM/Lmxlbmd0aCkgewogICAgICBwcmV2aWV3TWFjaGluZUlkLnZhbHVlID0gcC5tYWNoaW5lc1swXS5tYWNoaW5lX2lkCiAgICB9CiAgfSBmaW5hbGx5IHsKICAgIGxvYWRpbmcudmFsdWUgPSBmYWxzZQogIH0KfQoKZnVuY3Rpb24gc3luY1RoZW1lRm9ybSh0KSB7CiAgdGhlbWVGb3JtLnZhbHVlID0gewogICAgYnJhbmRfY29sb3I6IHQuYnJhbmRfY29sb3IsCiAgICBhY2NlbnRfY29sb3I6IHQuYWNjZW50X2NvbG9yLAogICAgdGV4dF9jb2xvcjogdC50ZXh0X2NvbG9yLAogICAgYmFja2dyb3VuZF90eXBlOiB0LmJhY2tncm91bmRfdHlwZSwKICAgIGJhY2tncm91bmRfdmFsdWU6IHQuYmFja2dyb3VuZF92YWx1ZSwKICAgIGZvbnRfZmFtaWx5OiB0LmZvbnRfZmFtaWx5CiAgfQp9CmZ1bmN0aW9uIHN5bmNINUZvcm0oaCkgewogIGNvbnN0IGNsb25lID0gKHYsIGZhbGxiYWNrKSA9PiBKU09OLnBhcnNlKEpTT04uc3RyaW5naWZ5KHYgPz8gZmFsbGJhY2spKQogIGNvbnN0IGJsb2NrcyA9IGNsb25lKGguYmxvY2tzLCBbXSkKICAvLyDlkJHlkI7lhbzlrrnvvJrku44gYmxvY2tzIOS4reaPkOWPluaXp+Wtl+auteWAvO+8iOaWsOagt+W8j+S/neWtmOeahOmhtemdou+8iQogIGNvbnN0IGZvcm0gPSB7CiAgICBoZWFkZXJfdGl0bGU6IGguaGVhZGVyX3RpdGxlIHx8ICcnLAogICAgaGVhZGVyX3N1YnRpdGxlOiBoLmhlYWRlcl9zdWJ0aXRsZSB8fCAnJywKICAgIGJsb2NrcywKICAgIGZvcm1fZmllbGRzOiBjbG9uZShoLmZvcm1fZmllbGRzLCBbXSksCiAgICBwcml2YWN5OiBjbG9uZShoLnByaXZhY3ksIHsgZW5hYmxlZDogdHJ1ZSwgdGV4dDogJycsIHVybDogJycgfSksCiAgICBzdWJtaXRfYnV0dG9uOiBjbG9uZShoLnN1Ym1pdF9idXR0b24sIHsgdGV4dDogJ+eri+WNs+mihuWPlicsIGNvbG9yOiAnJyB9KSwKICAgIHN1Y2Nlc3NfdmlldzogY2xvbmUoaC5zdWNjZXNzX3ZpZXcsIHsgdGl0bGU6ICcnLCBzdWJ0aXRsZTogJycsIGNvZGVfbGFiZWw6ICcnLCBmb290ZXJfdGlwOiAnJyB9KSwKICAgIHJhdGVfbGltaXQ6IGgucmF0ZV9saW1pdCB8fCAncGVyX2RldmljZV9kYXknLAogICAgcGFnZTFfYmFja2dyb3VuZDogeyBmaXQ6ICdjb3ZlcicsIC4uLmNsb25lKGgucGFnZTFfYmFja2dyb3VuZCwgeyB0eXBlOiAnY29sb3InLCB2YWx1ZTogJyMwYTBhMGEnLCBmaXQ6ICdjb3ZlcicgfSkgfSwKICAgIHBhZ2UyX2JhY2tncm91bmQ6IHsgZml0OiAnY292ZXInLCAuLi5jbG9uZShoLnBhZ2UyX2JhY2tncm91bmQsIHsgdHlwZTogJ2NvbG9yJywgdmFsdWU6ICcjMGEwYTBhJywgZml0OiAnY292ZXInIH0pIH0sCiAgICBwYWdlM19iYWNrZ3JvdW5kOiB7IGZpdDogJ2NvdmVyJywgLi4uY2xvbmUoaC5wYWdlM19iYWNrZ3JvdW5kLCB7IHR5cGU6ICdjb2xvcicsIHZhbHVlOiAnIzBhMGEwYScsIGZpdDogJ2NvdmVyJyB9KSB9LAogICAgcGFnZTFfYnV0dG9uX3RleHQ6IGgucGFnZTFfYnV0dG9uX3RleHQgfHwgJ+S4i+S4gOatpScsCiAgICBwYWdlMV9idXR0b25fZm9udF9zaXplOiBoLnBhZ2UxX2J1dHRvbl9mb250X3NpemUgfHwgJycsCiAgICBwYWdlMV9idXR0b25fcGFkZGluZzogaC5wYWdlMV9idXR0b25fcGFkZGluZyB8fCAnJywKICAgIHBhZ2UxX2J1dHRvbl9mb250X2NvbG9yOiBoLnBhZ2UxX2J1dHRvbl9mb250X2NvbG9yIHx8ICcnLAogICAgcGFnZTFfYnV0dG9uX2JnX2NvbG9yOiBoLnBhZ2UxX2J1dHRvbl9iZ19jb2xvciB8fCAnJywKICAgIHBhZ2UyX2J1dHRvbl90ZXh0OiBoLnBhZ2UyX2J1dHRvbl90ZXh0IHx8ICfnq4vljbPpooblj5YnLAogICAgaGVhZGVyX3Bvc2l0aW9uOiBoLmhlYWRlcl9wb3NpdGlvbiB8fCB7IHg6IDUwLCB5OiAxMCB9LAogICAgYnV0dG9uX3Bvc2l0aW9uOiBoLmJ1dHRvbl9wb3NpdGlvbiB8fCB7IHg6IDUwLCB5OiA4MCB9LAogIH0KICBmb3IgKGNvbnN0IGIgb2YgYmxvY2tzKSB7CiAgICBpZiAoYi50eXBlID09PSAnaGVhZGVyJykgewogICAgICBpZiAoYi5wcm9wcy50aXRsZSkgZm9ybS5oZWFkZXJfdGl0bGUgPSBiLnByb3BzLnRpdGxlCiAgICAgIGlmIChiLnByb3BzLnN1YnRpdGxlKSBmb3JtLmhlYWRlcl9zdWJ0aXRsZSA9IGIucHJvcHMuc3VidGl0bGUKICAgIH0KICAgIGlmIChiLnR5cGUgPT09ICdmb3JtJykgewogICAgICBpZiAoYi5wcm9wcy5maWVsZHM/Lmxlbmd0aCkgZm9ybS5mb3JtX2ZpZWxkcyA9IGNsb25lKGIucHJvcHMuZmllbGRzLCBbXSkKICAgICAgaWYgKGIucHJvcHMuc3VibWl0X2J1dHRvbikgZm9ybS5zdWJtaXRfYnV0dG9uID0geyAuLi5mb3JtLnN1Ym1pdF9idXR0b24sIC4uLmIucHJvcHMuc3VibWl0X2J1dHRvbiB9CiAgICAgIGlmIChiLnByb3BzLnJhdGVfbGltaXQpIGZvcm0ucmF0ZV9saW1pdCA9IGIucHJvcHMucmF0ZV9saW1pdAogICAgfQogICAgaWYgKGIudHlwZSA9PT0gJ3ByaXZhY3knICYmIGIucHJvcHMuZW5hYmxlZCkgewogICAgICBmb3JtLnByaXZhY3kgPSB7IGVuYWJsZWQ6IHRydWUsIHRleHQ6IGIucHJvcHMudGV4dCB8fCAnJywgdXJsOiBiLnByb3BzLnVybCB8fCAnJyB9CiAgICB9CiAgICBpZiAoYi50eXBlID09PSAnc3VjY2VzcycpIHsKICAgICAgZm9ybS5zdWNjZXNzX3ZpZXcgPSB7IHRpdGxlOiBiLnByb3BzLnRpdGxlIHx8ICcnLCBzdWJ0aXRsZTogYi5wcm9wcy5zdWJ0aXRsZSB8fCAnJywgY29kZV9sYWJlbDogYi5wcm9wcy5jb2RlX2xhYmVsIHx8ICcnLCBmb290ZXJfdGlwOiBiLnByb3BzLmZvb3Rlcl90aXAgfHwgJycgfQogICAgfQogIH0KICBoNUZvcm0udmFsdWUgPSBmb3JtCn0KCmZ1bmN0aW9uIHN5bmNMZWRGb3JtKGwpIHsKICBjb25zdCBjbG9uZSA9ICh2LCBmYWxsYmFjaykgPT4gSlNPTi5wYXJzZShKU09OLnN0cmluZ2lmeSh2ID8/IGZhbGxiYWNrKSkKICBsZWRGb3JtLnZhbHVlID0gewogICAgaGVhZGVyX3RpdGxlOiBsLmhlYWRlcl90aXRsZSB8fCAnJywKICAgIGhlYWRlcl9zdWJ0aXRsZTogbC5oZWFkZXJfc3VidGl0bGUgfHwgJycsCiAgICBhZHM6IGNsb25lKGwuYWRzLCBbXSksCiAgICBxcjogY2xvbmUobC5xciwgeyBsYWJlbDogJycsIHVybDogJycgfSksCiAgICBpbnB1dF9jb25maWc6IGNsb25lKGwuaW5wdXRfY29uZmlnLCB7IGxhYmVsOiAnJywgcGxhY2Vob2xkZXI6ICcnLCBzdWJtaXRfdGV4dDogJycsIHN1Y2Nlc3NfdGV4dDogJycgfSksCiAgICBmb290ZXJfdGlwOiBsLmZvb3Rlcl90aXAgfHwgJycsCiAgICBwYWdlMV9ibG9ja3M6IGNsb25lKGwucGFnZTFfYmxvY2tzLCBbXSksCiAgICBwYWdlMl9ibG9ja3M6IGNsb25lKGwucGFnZTJfYmxvY2tzLCBbXSksCiAgICBwYWdlMV9iYWNrZ3JvdW5kOiB7IGZpdDogJ2NvdmVyJywgLi4uY2xvbmUobC5wYWdlMV9iYWNrZ3JvdW5kLCB7IHR5cGU6ICdjb2xvcicsIHZhbHVlOiAnIzBhMGEwYScsIGZpdDogJ2NvdmVyJyB9KSB9LAogICAgcGFnZTJfYmFja2dyb3VuZDogeyBmaXQ6ICdjb3ZlcicsIC4uLmNsb25lKGwucGFnZTJfYmFja2dyb3VuZCwgeyB0eXBlOiAnY29sb3InLCB2YWx1ZTogJyMwYTBhMGEnLCBmaXQ6ICdjb3ZlcicgfSkgfSwKICB9Cn0KCmZ1bmN0aW9uIHJlc2V0VGhlbWUoKSB7IHN5bmNUaGVtZUZvcm0odGhlbWUudmFsdWUpIH0KZnVuY3Rpb24gcmVzZXRINSgpIHsKICAvLyDlj5jkvZPnvJbovpHmqKHlvI/vvJrmgaLlpI3liLDlj5jkvZPlv6vnhacKICBpZiAodmFyaWFudEVkaXRpbmcudmFsdWUgJiYgZXhwZXJpbWVudC52YWx1ZSkgewogICAgY29uc3QgdiA9IGV4cGVyaW1lbnQudmFsdWUudmFyaWFudHMuZmluZCh4ID0+IHguaWQgPT09IHZhcmlhbnRFZGl0aW5nLnZhbHVlLmlkKQogICAgaWYgKHYpIHsKICAgICAgY29uc3Qgc25hcCA9IHYuaDVfc25hcHNob3QgfHwge30KICAgICAgY29uc3QgYmFzZSA9IF9saXZlSDVCYWNrdXAudmFsdWUgfHwge30KICAgICAgaDVGb3JtLnZhbHVlID0gewogICAgICAgIC4uLmJhc2UsIC4uLnNuYXAsCiAgICAgICAgc3VibWl0X2J1dHRvbjogeyAuLi4oYmFzZS5zdWJtaXRfYnV0dG9uIHx8IHt9KSwgLi4uKHNuYXAuc3VibWl0X2J1dHRvbiB8fCB7fSkgfSwKICAgICAgICBwcml2YWN5OiB7IC4uLihiYXNlLnByaXZhY3kgfHwge30pLCAuLi4oc25hcC5wcml2YWN5IHx8IHt9KSB9LAogICAgICAgIHN1Y2Nlc3NfdmlldzogeyAuLi4oYmFzZS5zdWNjZXNzX3ZpZXcgfHwge30pLCAuLi4oc25hcC5zdWNjZXNzX3ZpZXcgfHwge30pIH0sCiAgICAgIH0KICAgIH0KICAgIHJldHVybgogIH0KICBzeW5jSDVGb3JtKGg1LnZhbHVlKQp9CmZ1bmN0aW9uIHJlc2V0TGVkKCkgeyBzeW5jTGVkRm9ybShsZWQudmFsdWUpIH0KCi8vID09PT09PT09PT09PSDkv53lrZggPT09PT09PT09PT09CmFzeW5jIGZ1bmN0aW9uIHNhdmVUaGVtZSgpIHsKICBzYXZpbmcudmFsdWUgPSB0cnVlCiAgdHJ5IHsKICAgIGNvbnN0IHVwZGF0ZWQgPSBhd2FpdCB1cGRhdGVQcm9qZWN0VGhlbWUocHJvamVjdElkLCB7IC4uLnRoZW1lRm9ybS52YWx1ZSB9KQogICAgdGhlbWUudmFsdWUgPSB1cGRhdGVkCiAgICBFbE1lc3NhZ2Uuc3VjY2Vzcygn5Li76aKY5bey5L+d5a2YJykKICB9IGZpbmFsbHkgewogICAgc2F2aW5nLnZhbHVlID0gZmFsc2UKICB9Cn0KCmFzeW5jIGZ1bmN0aW9uIHNhdmVINSgpIHsKICAvLyDlj6rkv53nlZnlhoXlrrnljLrlnZfvvIxoZWFkZXIvZm9ybS9wcml2YWN5L3N1Y2Nlc3Mg55Sx54us56uL5Y2h54mH566h55CGCiAgY29uc3QgcGF5bG9hZCA9IHsKICAgIGJsb2NrczogaDVGb3JtLnZhbHVlLmJsb2Nrcy5maWx0ZXIoYiA9PiAhWydoZWFkZXInLCdmb3JtJywncHJpdmFjeScsJ3N1Y2Nlc3MnXS5pbmNsdWRlcyhiLnR5cGUpKSwKICAgIGhlYWRlcl90aXRsZTogaDVGb3JtLnZhbHVlLmhlYWRlcl90aXRsZSwKICAgIGhlYWRlcl9zdWJ0aXRsZTogaDVGb3JtLnZhbHVlLmhlYWRlcl9zdWJ0aXRsZSwKICAgIGZvcm1fZmllbGRzOiBoNUZvcm0udmFsdWUuZm9ybV9maWVsZHMsCiAgICBwcml2YWN5OiBoNUZvcm0udmFsdWUucHJpdmFjeSwKICAgIHN1Ym1pdF9idXR0b246IGg1Rm9ybS52YWx1ZS5zdWJtaXRfYnV0dG9uLAogICAgcmF0ZV9saW1pdDogaDVGb3JtLnZhbHVlLnJhdGVfbGltaXQsCiAgICBzdWNjZXNzX3ZpZXc6IGg1Rm9ybS52YWx1ZS5zdWNjZXNzX3ZpZXcsCiAgICBwYWdlMV9iYWNrZ3JvdW5kOiBoNUZvcm0udmFsdWUucGFnZTFfYmFja2dyb3VuZCwKICAgIHBhZ2UyX2JhY2tncm91bmQ6IGg1Rm9ybS52YWx1ZS5wYWdlMl9iYWNrZ3JvdW5kLAogICAgcGFnZTNfYmFja2dyb3VuZDogaDVGb3JtLnZhbHVlLnBhZ2UzX2JhY2tncm91bmQsCiAgICBwYWdlMV9idXR0b25fdGV4dDogaDVGb3JtLnZhbHVlLnBhZ2UxX2J1dHRvbl90ZXh0LAogICAgcGFnZTFfYnV0dG9uX2ZvbnRfc2l6ZTogaDVGb3JtLnZhbHVlLnBhZ2UxX2J1dHRvbl9mb250X3NpemUsCiAgICBwYWdlMV9idXR0b25fcGFkZGluZzogaDVGb3JtLnZhbHVlLnBhZ2UxX2J1dHRvbl9wYWRkaW5nLAogICAgcGFnZTFfYnV0dG9uX2ZvbnRfY29sb3I6IGg1Rm9ybS52YWx1ZS5wYWdlMV9idXR0b25fZm9udF9jb2xvciwKICAgIHBhZ2UxX2J1dHRvbl9iZ19jb2xvcjogaDVGb3JtLnZhbHVlLnBhZ2UxX2J1dHRvbl9iZ19jb2xvciwKICAgIHBhZ2UyX2J1dHRvbl90ZXh0OiBoNUZvcm0udmFsdWUucGFnZTJfYnV0dG9uX3RleHQsCiAgICBoZWFkZXJfcG9zaXRpb246IGg1Rm9ybS52YWx1ZS5oZWFkZXJfcG9zaXRpb24sCiAgICBidXR0b25fcG9zaXRpb246IGg1Rm9ybS52YWx1ZS5idXR0b25fcG9zaXRpb24sCiAgfQoKICAvLyBQaGFzZSAyLjTvvJrlj5jkvZPnvJbovpHmqKHlvI8g4oaSIOS/neWtmOWIsOivpeWPmOS9k+W/q+eFpwogIGlmICh2YXJpYW50RWRpdGluZy52YWx1ZSkgewogICAgc2F2aW5nLnZhbHVlID0gdHJ1ZQogICAgdHJ5IHsKICAgICAgYXdhaXQgdXBkYXRlRXhwZXJpbWVudFZhcmlhbnQocHJvamVjdElkLCB2YXJpYW50RWRpdGluZy52YWx1ZS5pZCwgeyBoNV9zbmFwc2hvdDogcGF5bG9hZCB9KQogICAgICBhd2FpdCBsb2FkRXhwZXJpbWVudCgpCiAgICAgIEVsTWVzc2FnZS5zdWNjZXNzKGDlj5jkvZMgJHt2YXJpYW50RWRpdGluZy52YWx1ZS5rZXl9IOW3suS/neWtmGApCiAgICAgIG5leHRUaWNrKHJlZnJlc2hQcmV2aWV3KQogICAgfSBmaW5hbGx5IHsKICAgICAgc2F2aW5nLnZhbHVlID0gZmFsc2UKICAgIH0KICAgIHJldHVybgogIH0KCiAgc2F2aW5nLnZhbHVlID0gdHJ1ZQogIHRyeSB7CiAgICBjb25zdCB1cGRhdGVkID0gYXdhaXQgdXBkYXRlUHJvamVjdEg1KHByb2plY3RJZCwgcGF5bG9hZCkKICAgIGg1LnZhbHVlID0gdXBkYXRlZAogICAgc3luY0g1Rm9ybSh1cGRhdGVkKQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoJ+iNieeov+W3suS/neWtmO+8iOeCueWHu+OAjOWPkeW4g+WIsOe6v+S4iuOAjeiuqeeUqOaIt+eci+WIsO+8iScpCiAgICBuZXh0VGljayhyZWZyZXNoUHJldmlldykKICB9IGZpbmFsbHkgewogICAgc2F2aW5nLnZhbHVlID0gZmFsc2UKICB9Cn0KCmFzeW5jIGZ1bmN0aW9uIHNhdmVMZWQoKSB7CiAgc2F2aW5nLnZhbHVlID0gdHJ1ZQogIHRyeSB7CiAgICBjb25zdCB1cGRhdGVkID0gYXdhaXQgdXBkYXRlUHJvamVjdExlZChwcm9qZWN0SWQsIHsgLi4ubGVkRm9ybS52YWx1ZSB9KQogICAgbGVkLnZhbHVlID0gdXBkYXRlZAogICAgc3luY0xlZEZvcm0odXBkYXRlZCkKICAgIEVsTWVzc2FnZS5zdWNjZXNzKCdMRUQg6I2J56i/5bey5L+d5a2Y77yI54K544CM5Y+R5biDIExFRCDlpKflsY/jgI3mjqjpgIHliLDorr7lpIfvvIknKQogICAgbmV4dFRpY2socmVmcmVzaExlZFByZXZpZXcpCiAgfSBmaW5hbGx5IHsKICAgIHNhdmluZy52YWx1ZSA9IGZhbHNlCiAgfQp9CgovLyA9PT09PT09PT09PT0g5paH5Lu25LiK5Lyg77yIbXVsdGlwYXJ077yJID09PT09PT09PT09PQphc3luYyBmdW5jdGlvbiB1cGxvYWRGaWxlKGZpZWxkLCBvcHQpIHsKICBjb25zdCBmZCA9IG5ldyBGb3JtRGF0YSgpCiAgZmQuYXBwZW5kKGZpZWxkLCBvcHQuZmlsZSkKICB0cnkgewogICAgY29uc3QgdXBkYXRlZCA9IGF3YWl0IHVwZGF0ZVByb2plY3RUaGVtZShwcm9qZWN0SWQsIGZkKQogICAgdGhlbWUudmFsdWUgPSB1cGRhdGVkCiAgICBFbE1lc3NhZ2Uuc3VjY2Vzcygn5LiK5Lyg5oiQ5YqfJykKICB9IGNhdGNoIChlKSB7CiAgICBvcHQub25FcnJvcj8uKGUpCiAgfQp9Cgphc3luYyBmdW5jdGlvbiB1cGxvYWRMZWRGaWxlKGZpZWxkLCBvcHQpIHsKICBjb25zdCBmZCA9IG5ldyBGb3JtRGF0YSgpCiAgZmQuYXBwZW5kKGZpZWxkLCBvcHQuZmlsZSkKICB0cnkgewogICAgY29uc3QgdXBkYXRlZCA9IGF3YWl0IHVwZGF0ZVByb2plY3RMZWQocHJvamVjdElkLCBmZCkKICAgIGxlZC52YWx1ZSA9IHVwZGF0ZWQKICAgIEVsTWVzc2FnZS5zdWNjZXNzKCfkuIrkvKDmiJDlip8nKQogICAgbmV4dFRpY2socmVmcmVzaExlZFByZXZpZXcpCiAgfSBjYXRjaCAoZSkgewogICAgb3B0Lm9uRXJyb3I/LihlKQogIH0KfQoKLy8g5Yy65Z2X5Zu+54mH5LiK5LygIOKAlCDkuIrkvKDmiJDlip/lkI7oh6rliqjkv53lrZjojYnnqL/lubbliLfmlrDpooTop4gKYXN5bmMgZnVuY3Rpb24gb25VcGxvYWRCbG9ja0ltYWdlKG9wdCwgcHJvcHMsIGZpZWxkID0gJ3VybCcpIHsKICB0cnkgewogICAgY29uc3QgcmVzID0gYXdhaXQgdXBsb2FkQmxvY2tJbWFnZShwcm9qZWN0SWQsIG9wdC5maWxlKQogICAgcHJvcHNbZmllbGRdID0gcmVzLnVybAogICAgLy8g5aaC5p6c5LiK5Lyg55qE5piv6IOM5pmv5Zu+77yIZmllbGQ9J3ZhbHVlJ++8ie+8jOiHquWKqOaKiiB0eXBlIOaUueS4uiAnaW1hZ2UnCiAgICBpZiAoZmllbGQgPT09ICd2YWx1ZScgJiYgcHJvcHMudHlwZSAhPT0gdW5kZWZpbmVkKSB7CiAgICAgIHByb3BzLnR5cGUgPSAnaW1hZ2UnCiAgICB9CiAgICAvLyDoh6rliqjkv53lrZjlvZPliY3pobXpnaLvvIhINSDmiJYgTEVE77yJ5bm25Yi35paw6aKE6KeICiAgICBjb25zdCB0YWIgPSBhY3RpdmVUYWIudmFsdWUKICAgIGlmICh0YWIgPT09ICdoNScgJiYgIXZhcmlhbnRFZGl0aW5nLnZhbHVlKSB7CiAgICAgIGF3YWl0IHNhdmVINV9TaWxlbnQoKQogICAgfSBlbHNlIGlmICh0YWIgPT09ICdsZWQnKSB7CiAgICAgIGF3YWl0IHNhdmVMZWRfU2lsZW50KCkKICAgIH0KICAgIEVsTWVzc2FnZS5zdWNjZXNzKCflm77niYflt7LkuIrkvKAnKQogIH0gY2F0Y2ggKGUpIHsKICAgIEVsTWVzc2FnZS5lcnJvcign5LiK5Lyg5aSx6LSlJykKICB9Cn0KCi8vIOmdmem7mOS/neWtmCBINe+8iOS4jeW8ueaIkOWKn+aPkOekuu+8iQphc3luYyBmdW5jdGlvbiBzYXZlSDVfU2lsZW50KCkgewogIGNvbnN0IHBheWxvYWQgPSB7CiAgICBibG9ja3M6IGg1Rm9ybS52YWx1ZS5ibG9ja3MuZmlsdGVyKGIgPT4gIVsnaGVhZGVyJywnZm9ybScsJ3ByaXZhY3knLCdzdWNjZXNzJ10uaW5jbHVkZXMoYi50eXBlKSksCiAgICBoZWFkZXJfdGl0bGU6IGg1Rm9ybS52YWx1ZS5oZWFkZXJfdGl0bGUsCiAgICBoZWFkZXJfc3VidGl0bGU6IGg1Rm9ybS52YWx1ZS5oZWFkZXJfc3VidGl0bGUsCiAgICBmb3JtX2ZpZWxkczogaDVGb3JtLnZhbHVlLmZvcm1fZmllbGRzLAogICAgcHJpdmFjeTogaDVGb3JtLnZhbHVlLnByaXZhY3ksCiAgICBzdWJtaXRfYnV0dG9uOiBoNUZvcm0udmFsdWUuc3VibWl0X2J1dHRvbiwKICAgIHJhdGVfbGltaXQ6IGg1Rm9ybS52YWx1ZS5yYXRlX2xpbWl0LAogICAgc3VjY2Vzc192aWV3OiBoNUZvcm0udmFsdWUuc3VjY2Vzc192aWV3LAogICAgcGFnZTFfYmFja2dyb3VuZDogaDVGb3JtLnZhbHVlLnBhZ2UxX2JhY2tncm91bmQsCiAgICBwYWdlMl9iYWNrZ3JvdW5kOiBoNUZvcm0udmFsdWUucGFnZTJfYmFja2dyb3VuZCwKICAgIHBhZ2UzX2JhY2tncm91bmQ6IGg1Rm9ybS52YWx1ZS5wYWdlM19iYWNrZ3JvdW5kLAogICAgcGFnZTFfYnV0dG9uX3RleHQ6IGg1Rm9ybS52YWx1ZS5wYWdlMV9idXR0b25fdGV4dCwKICAgIHBhZ2UyX2J1dHRvbl90ZXh0OiBoNUZvcm0udmFsdWUucGFnZTJfYnV0dG9uX3RleHQsCiAgICBoZWFkZXJfcG9zaXRpb246IGg1Rm9ybS52YWx1ZS5oZWFkZXJfcG9zaXRpb24sCiAgICBidXR0b25fcG9zaXRpb246IGg1Rm9ybS52YWx1ZS5idXR0b25fcG9zaXRpb24sCiAgfQogIGNvbnN0IHVwZGF0ZWQgPSBhd2FpdCB1cGRhdGVQcm9qZWN0SDUocHJvamVjdElkLCBwYXlsb2FkKQogIGg1LnZhbHVlID0gdXBkYXRlZAogIHN5bmNINUZvcm0odXBkYXRlZCkKICBuZXh0VGljayhyZWZyZXNoUHJldmlldykKfQoKLy8g6Z2Z6buY5L+d5a2YIExFRO+8iOS4jeW8ueaIkOWKn+aPkOekuu+8iQphc3luYyBmdW5jdGlvbiBzYXZlTGVkX1NpbGVudCgpIHsKICBjb25zdCB1cGRhdGVkID0gYXdhaXQgdXBkYXRlUHJvamVjdExlZChwcm9qZWN0SWQsIHsgLi4ubGVkRm9ybS52YWx1ZSB9KQogIGxlZC52YWx1ZSA9IHVwZGF0ZWQKICBzeW5jTGVkRm9ybSh1cGRhdGVkKQogIG5leHRUaWNrKHJlZnJlc2hMZWRQcmV2aWV3KQp9CgovLyA9PT09PT09PT09PT0g5Y+R5biDID09PT09PT09PT09PQphc3luYyBmdW5jdGlvbiBvblB1Ymxpc2goKSB7CiAgY29uc3QgaXNMZWQgPSBhY3RpdmVUYWIudmFsdWUgPT09ICdsZWQnCiAgY29uc3QgdGl0bGUgPSBpc0xlZCA/ICflj5HluIMgTEVEIOWkp+Wxj+WIsOiuvuWkhycgOiAn5Y+R5biDIEg1IOWIsOe6v+S4iicKICB0cnkgewogICAgY29uc3QgeyB2YWx1ZTogbm90ZSB9ID0gYXdhaXQgRWxNZXNzYWdlQm94LnByb21wdCgn5Y+R5biD6K+05piO77yI5Y+v6YCJ77yJJywgdGl0bGUsIHsKICAgICAgY29uZmlybUJ1dHRvblRleHQ6ICflj5HluIMnLCBjYW5jZWxCdXR0b25UZXh0OiAn5Y+W5raIJywgaW5wdXRWYWx1ZTogJycKICAgIH0pCiAgICBwdWJsaXNoaW5nLnZhbHVlID0gdHJ1ZQogICAgaWYgKGlzTGVkKSB7CiAgICAgIGNvbnN0IHJlcyA9IGF3YWl0IHB1Ymxpc2hQcm9qZWN0TGVkKHByb2plY3RJZCwgbm90ZSB8fCAnJykKICAgICAgbGVkLnZhbHVlID0gcmVzLnBhZ2UKICAgICAgc3luY0xlZEZvcm0ocmVzLnBhZ2UpCiAgICAgIHZlcnNpb25zLnZhbHVlID0gYXdhaXQgbGlzdFBhZ2VWZXJzaW9ucyhwcm9qZWN0SWQpCiAgICAgIEVsTWVzc2FnZS5zdWNjZXNzKGBMRUQg5bey5Y+R5biDIHYke3Jlcy52ZXJzaW9ufWApCiAgICAgIG5leHRUaWNrKHJlZnJlc2hMZWRQcmV2aWV3KQogICAgfSBlbHNlIHsKICAgICAgY29uc3QgcmVzID0gYXdhaXQgcHVibGlzaFByb2plY3RINShwcm9qZWN0SWQsIG5vdGUgfHwgJycpCiAgICAgIGg1LnZhbHVlID0gcmVzLnBhZ2UKICAgICAgc3luY0g1Rm9ybShyZXMucGFnZSkKICAgICAgdmVyc2lvbnMudmFsdWUgPSBhd2FpdCBsaXN0UGFnZVZlcnNpb25zKHByb2plY3RJZCkKICAgICAgRWxNZXNzYWdlLnN1Y2Nlc3MoYEg1IOW3suWPkeW4gyB2JHtyZXMudmVyc2lvbn1gKQogICAgICBuZXh0VGljayhyZWZyZXNoUHJldmlldykKICAgIH0KICB9IGNhdGNoIChlKSB7CiAgICBpZiAoZSAhPT0gJ2NhbmNlbCcpIHRocm93IGUKICB9IGZpbmFsbHkgewogICAgcHVibGlzaGluZy52YWx1ZSA9IGZhbHNlCiAgfQp9CgovLyA9PT09PT09PT09PT0g54mI5pys5Zue5ruaID09PT09PT09PT09PQpjb25zdCByZXN0b3JlRGlhbG9nID0gcmVmKGZhbHNlKQpjb25zdCByZXN0b3JlVGFyZ2V0ID0gcmVmKG51bGwpCmNvbnN0IHJlc3RvcmluZyA9IHJlZihmYWxzZSkKY29uc3QgcmVzdG9yZU9wdGlvbnMgPSByZWYoeyBpbmNsdWRlX3RoZW1lOiB0cnVlLCBwdWJsaXNoOiBmYWxzZSB9KQoKZnVuY3Rpb24gaXNDdXJyZW50VmVyc2lvbihyb3cpIHsKICBpZiAocm93LnBhZ2VfdHlwZSA9PT0gJ2g1JykgcmV0dXJuIHJvdy52ZXJzaW9uID09PSBoNS52YWx1ZT8uY3VycmVudF92ZXJzaW9uCiAgaWYgKHJvdy5wYWdlX3R5cGUgPT09ICdsZWQnKSByZXR1cm4gcm93LnZlcnNpb24gPT09IGxlZC52YWx1ZT8uY3VycmVudF92ZXJzaW9uCiAgcmV0dXJuIGZhbHNlCn0KCmZ1bmN0aW9uIG9wZW5SZXN0b3JlRGlhbG9nKHJvdykgewogIHJlc3RvcmVUYXJnZXQudmFsdWUgPSByb3cKICByZXN0b3JlT3B0aW9ucy52YWx1ZSA9IHsgaW5jbHVkZV90aGVtZTogdHJ1ZSwgcHVibGlzaDogZmFsc2UgfQogIHJlc3RvcmVEaWFsb2cudmFsdWUgPSB0cnVlCn0KCmFzeW5jIGZ1bmN0aW9uIGRvUmVzdG9yZSgpIHsKICBpZiAoIXJlc3RvcmVUYXJnZXQudmFsdWUpIHJldHVybgogIHJlc3RvcmluZy52YWx1ZSA9IHRydWUKICB0cnkgewogICAgY29uc3QgcmVzID0gYXdhaXQgcmVzdG9yZVBhZ2VWZXJzaW9uKHByb2plY3RJZCwgcmVzdG9yZVRhcmdldC52YWx1ZS5pZCwgcmVzdG9yZU9wdGlvbnMudmFsdWUpCiAgICAvLyDph43mlrDmi4nlhajlpZfnirbmgIEKICAgIGNvbnN0IFtoLCBsLCB2XSA9IGF3YWl0IFByb21pc2UuYWxsKFsKICAgICAgZ2V0UHJvamVjdEg1KHByb2plY3RJZCksCiAgICAgIGdldFByb2plY3RMZWQocHJvamVjdElkKSwKICAgICAgbGlzdFBhZ2VWZXJzaW9ucyhwcm9qZWN0SWQpCiAgICBdKQogICAgaDUudmFsdWUgPSBoCiAgICBsZWQudmFsdWUgPSBsCiAgICB2ZXJzaW9ucy52YWx1ZSA9IHYKICAgIHN5bmNINUZvcm0oaCkKICAgIHN5bmNMZWRGb3JtKGwpCiAgICAvLyDlpoLmnpzkuLvpopjkuZ/ooqvmlLnkuobvvIzliLfkuIDkuIsKICAgIGlmIChyZXMucmVzdG9yZWQudGhlbWUpIHsKICAgICAgY29uc3QgdCA9IGF3YWl0IGdldFByb2plY3RUaGVtZShwcm9qZWN0SWQpCiAgICAgIHRoZW1lLnZhbHVlID0gdAogICAgICBzeW5jVGhlbWVGb3JtKHQpCiAgICB9CiAgICByZXN0b3JlRGlhbG9nLnZhbHVlID0gZmFsc2UKCiAgICBpZiAocmVzLm1vZGUgPT09ICdwdWJsaXNoJykgewogICAgICBFbE1lc3NhZ2Uuc3VjY2Vzcyhg5bey5Zue5rua5bm25Y+R5biD5Li6IHYke3Jlcy5yZXN0b3JlZC5wdWJsaXNoZWRfdmVyc2lvbn1gKQogICAgICBuZXh0VGljaygoKSA9PiB7CiAgICAgICAgaWYgKHJlc3RvcmVUYXJnZXQudmFsdWUucGFnZV90eXBlID09PSAnbGVkJykgcmVmcmVzaExlZFByZXZpZXcoKQogICAgICAgIGVsc2UgcmVmcmVzaFByZXZpZXcoKQogICAgICB9KQogICAgfSBlbHNlIHsKICAgICAgRWxNZXNzYWdlLnN1Y2Nlc3MoJ+W3suaBouWkjeWIsOiNieeov++8jOivt+WIsOWvueW6lCB0YWIg5qOA5p+l5ZCO54K544CM5Y+R5biD44CN55Sf5pWI5Yiw57q/5LiKJykKICAgICAgLy8g6Ieq5Yqo5YiH5Yiw5a+55bqUIHRhYu+8jOaWueS+v+eUqOaIt+eri+WIu+eci+WIsOe7k+aenAogICAgICBhY3RpdmVUYWIudmFsdWUgPSByZXN0b3JlVGFyZ2V0LnZhbHVlLnBhZ2VfdHlwZSA9PT0gJ2xlZCcgPyAnbGVkJyA6ICdoNScKICAgICAgbmV4dFRpY2soKCkgPT4gewogICAgICAgIGlmIChyZXN0b3JlVGFyZ2V0LnZhbHVlLnBhZ2VfdHlwZSA9PT0gJ2xlZCcpIHJlZnJlc2hMZWRQcmV2aWV3KCkKICAgICAgICBlbHNlIHJlZnJlc2hQcmV2aWV3KCkKICAgICAgfSkKICAgIH0KICB9IGZpbmFsbHkgewogICAgcmVzdG9yaW5nLnZhbHVlID0gZmFsc2UKICB9Cn0KCmZ1bmN0aW9uIG9wZW5QcmV2aWV3KCkgewogIGlmIChhY3RpdmVUYWIudmFsdWUgPT09ICdsZWQnKSB7CiAgICBpZiAoIXByZXZpZXdNYWNoaW5lSWQudmFsdWUpIHsKICAgICAgRWxNZXNzYWdlLndhcm5pbmcoJ+ivt+WFiOWcqOWPs+S+p+mihOiniOagj+mAieaLqeS4gOWPsOiuvuWkhycpCiAgICAgIHJldHVybgogICAgfQogICAgd2luZG93Lm9wZW4oYC9sZWQvJHtwcmV2aWV3TWFjaGluZUlkLnZhbHVlfS8/cHJvamVjdF9pZD0ke3Byb2plY3RJZH1gLCAnX2JsYW5rJykKICB9IGVsc2UgewogICAgd2luZG93Lm9wZW4oYC9wLyR7cHJvamVjdElkfS9gLCAnX2JsYW5rJykKICB9Cn0KCi8vID09PT09PT09PT09PSBQaGFzZSAyLjIg5pWw5o2u55yL5p2/ID09PT09PT09PT09PQpjb25zdCBzdGF0c0RheXMgPSByZWYoMTQpCmNvbnN0IHN0YXRzTG9hZGluZyA9IHJlZihmYWxzZSkKY29uc3QgZnVubmVsID0gcmVmKG51bGwpCmNvbnN0IHRyZW5kQ2hhcnRFbCA9IHJlZihudWxsKQpjb25zdCBmdW5uZWxDaGFydEVsID0gcmVmKG51bGwpCmxldCB0cmVuZENoYXJ0ID0gbnVsbApsZXQgZnVubmVsQ2hhcnQgPSBudWxsCgphc3luYyBmdW5jdGlvbiBsb2FkRnVubmVsKCkgewogIHN0YXRzTG9hZGluZy52YWx1ZSA9IHRydWUKICB0cnkgewogICAgZnVubmVsLnZhbHVlID0gYXdhaXQgZ2V0UHJvamVjdEZ1bm5lbChwcm9qZWN0SWQsIHN0YXRzRGF5cy52YWx1ZSkKICAgIGF3YWl0IG5leHRUaWNrKCkKICAgIHJlbmRlclRyZW5kKCkKICAgIHJlbmRlckZ1bm5lbCgpCiAgfSBmaW5hbGx5IHsKICAgIHN0YXRzTG9hZGluZy52YWx1ZSA9IGZhbHNlCiAgfQp9Cgphc3luYyBmdW5jdGlvbiBkb0V4cG9ydEZ1bm5lbCgpIHsKICB0cnkgewogICAgYXdhaXQgZXhwb3J0RnVubmVsQ3N2KHByb2plY3RJZCwgc3RhdHNEYXlzLnZhbHVlKQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoJ0NTViDlt7LkuIvovb0nKQogIH0gY2F0Y2ggKGUpIHsgLyogaHR0cCDmi6bmiKrlmajlt7LlvLnplJkgKi8gfQp9Cgphc3luYyBmdW5jdGlvbiBkb0V4cG9ydEV4cGVyaW1lbnQoKSB7CiAgdHJ5IHsKICAgIGF3YWl0IGV4cG9ydEV4cGVyaW1lbnRDc3YocHJvamVjdElkKQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoJ0NTViDlt7LkuIvovb0nKQogIH0gY2F0Y2ggKGUpIHsgLyogaHR0cCDmi6bmiKrlmajlt7LlvLnplJkgKi8gfQp9CgpmdW5jdGlvbiByZW5kZXJUcmVuZCgpIHsKICBpZiAoIXRyZW5kQ2hhcnRFbC52YWx1ZSB8fCAhZnVubmVsLnZhbHVlKSByZXR1cm4KICBpZiAoIXRyZW5kQ2hhcnQpIHRyZW5kQ2hhcnQgPSBlY2hhcnRzLmluaXQodHJlbmRDaGFydEVsLnZhbHVlKQogIGNvbnN0IHMgPSBmdW5uZWwudmFsdWUuc2VyaWVzCiAgdHJlbmRDaGFydC5zZXRPcHRpb24oewogICAgdG9vbHRpcDogeyB0cmlnZ2VyOiAnYXhpcycgfSwKICAgIGxlZ2VuZDogeyBkYXRhOiBbJ0g1IOiuv+mXricsICdMRUQg6K6/6ZeuJywgJ+mihueggScsICfmoLjplIAnXSwgdG9wOiAwIH0sCiAgICBncmlkOiB7IGxlZnQ6IDQwLCByaWdodDogMjAsIHRvcDogNDAsIGJvdHRvbTogNDAgfSwKICAgIHhBeGlzOiB7IHR5cGU6ICdjYXRlZ29yeScsIGRhdGE6IHMubWFwKGQgPT4gZC5kYXRlLnNsaWNlKDUpKSB9LAogICAgeUF4aXM6IHsgdHlwZTogJ3ZhbHVlJywgbWluSW50ZXJ2YWw6IDEgfSwKICAgIHNlcmllczogWwogICAgICB7IG5hbWU6ICdINSDorr/pl64nLCB0eXBlOiAnbGluZScsIHNtb290aDogdHJ1ZSwgZGF0YTogcy5tYXAoZCA9PiBkLmg1X3Zpc2l0cyksIGl0ZW1TdHlsZTogeyBjb2xvcjogJyM0MDllZmYnIH0gfSwKICAgICAgeyBuYW1lOiAnTEVEIOiuv+mXricsIHR5cGU6ICdsaW5lJywgc21vb3RoOiB0cnVlLCBkYXRhOiBzLm1hcChkID0+IGQubGVkX3Zpc2l0cyksIGl0ZW1TdHlsZTogeyBjb2xvcjogJyNlNmEyM2MnIH0gfSwKICAgICAgeyBuYW1lOiAn6aKG56CBJywgdHlwZTogJ2xpbmUnLCBzbW9vdGg6IHRydWUsIGRhdGE6IHMubWFwKGQgPT4gZC5jbGFpbXMpLCBpdGVtU3R5bGU6IHsgY29sb3I6ICcjNjdjMjNhJyB9IH0sCiAgICAgIHsgbmFtZTogJ+aguOmUgCcsIHR5cGU6ICdsaW5lJywgc21vb3RoOiB0cnVlLCBkYXRhOiBzLm1hcChkID0+IGQucmVkZWVtcyksIGl0ZW1TdHlsZTogeyBjb2xvcjogJyNmNTZjNmMnIH0gfSwKICAgIF0KICB9LCB0cnVlKQp9CgpmdW5jdGlvbiByZW5kZXJGdW5uZWwoKSB7CiAgaWYgKCFmdW5uZWxDaGFydEVsLnZhbHVlIHx8ICFmdW5uZWwudmFsdWUpIHJldHVybgogIGlmICghZnVubmVsQ2hhcnQpIGZ1bm5lbENoYXJ0ID0gZWNoYXJ0cy5pbml0KGZ1bm5lbENoYXJ0RWwudmFsdWUpCiAgY29uc3QgdCA9IGZ1bm5lbC52YWx1ZS50b3RhbHMKICBmdW5uZWxDaGFydC5zZXRPcHRpb24oewogICAgdG9vbHRpcDogeyB0cmlnZ2VyOiAnaXRlbScsIGZvcm1hdHRlcjogJ3tifToge2N9JyB9LAogICAgc2VyaWVzOiBbewogICAgICB0eXBlOiAnZnVubmVsJywKICAgICAgbGVmdDogJzEwJScsIHJpZ2h0OiAnMTAlJywgdG9wOiAxMCwgYm90dG9tOiAxMCwKICAgICAgd2lkdGg6ICc4MCUnLAogICAgICBzb3J0OiAnZGVzY2VuZGluZycsCiAgICAgIGdhcDogNCwKICAgICAgbGFiZWw6IHsgc2hvdzogdHJ1ZSwgcG9zaXRpb246ICdpbnNpZGUnLCBmb3JtYXR0ZXI6ICd7Yn1cbntjfScgfSwKICAgICAgbGFiZWxMaW5lOiB7IHNob3c6IGZhbHNlIH0sCiAgICAgIGRhdGE6IFsKICAgICAgICB7IHZhbHVlOiB0Lmg1X3Zpc2l0cywgbmFtZTogJ0g1IOiuv+mXricgfSwKICAgICAgICB7IHZhbHVlOiB0LnV2X2g1LCBuYW1lOiAnSDUg54us56uL6K6/5a6iJyB9LAogICAgICAgIHsgdmFsdWU6IHQuY2xhaW1zLCBuYW1lOiAn6aKG56CBJyB9LAogICAgICAgIHsgdmFsdWU6IHQucmVkZWVtcywgbmFtZTogJ+aguOmUgCcgfSwKICAgICAgXQogICAgfV0KICB9LCB0cnVlKQp9CgovLyDliIfliLAgc3RhdHMgdGFiIOaJjeWKoOi9ve+8jOmBv+WFjeS4jeW/heimgeivt+axggp3YXRjaChhY3RpdmVUYWIsICh0YWIsIG9sZFRhYikgPT4gewogIGlmICh0YWIgPT09ICdzdGF0cycpIGxvYWRGdW5uZWwoKQogIGlmICh0YWIgPT09ICdleHBlcmltZW50JykgbG9hZEV4cGVyaW1lbnQoKQogIC8vIFBoYXNlIDIuNO+8muemu+W8gCBINSB0YWIg6Ieq5Yqo6YCA5Ye65Y+Y5L2T57yW6L6R5qih5byPCiAgaWYgKG9sZFRhYiA9PT0gJ2g1JyAmJiB0YWIgIT09ICdoNScgJiYgdmFyaWFudEVkaXRpbmcudmFsdWUpIHsKICAgIGV4aXRWYXJpYW50RWRpdGluZygpCiAgfQp9KQoKLy8gPT09PT09PT09PT09IFBoYXNlIDIuMyBBL0Ig5a6e6aqMID09PT09PT09PT09PQpjb25zdCBleHBlcmltZW50ID0gcmVmKG51bGwpCmNvbnN0IGV4cFN0YXRzID0gcmVmKG51bGwpCmNvbnN0IGV4cEFjdGluZyA9IHJlZihmYWxzZSkKY29uc3QgY3JlYXRlRXhwRGlhbG9nID0gcmVmKGZhbHNlKQpjb25zdCBuZXdFeHAgPSByZWYoewogIG5hbWU6ICdBL0Ig5a6e6aqMJywgaHlwb3RoZXNpczogJycsCiAgdmFyaWFudF9jb3VudDogMiwKICB0cmFmZmljX3NoYXJlczogWzUwLCA1MF0sCn0pCmNvbnN0IHNoYXJlU3VtID0gY29tcHV0ZWQoKCkgPT4gKG5ld0V4cC52YWx1ZS50cmFmZmljX3NoYXJlcyB8fCBbXSkucmVkdWNlKChhLCBiKSA9PiBhICsgKGIgfHwgMCksIDApKQpmdW5jdGlvbiByZWJhbGFuY2VTaGFyZXMoKSB7CiAgY29uc3QgbiA9IG5ld0V4cC52YWx1ZS52YXJpYW50X2NvdW50CiAgY29uc3QgcGVyID0gTWF0aC5mbG9vcigxMDAgLyBuKQogIGNvbnN0IGFyciA9IEFycmF5KG4pLmZpbGwocGVyKQogIGFycltuIC0gMV0gKz0gMTAwIC0gcGVyICogbgogIG5ld0V4cC52YWx1ZS50cmFmZmljX3NoYXJlcyA9IGFycgp9CgovLyBQaGFzZSAyLjQg5Y+Y5L2T57yW6L6R5qih5byP77ya6L+b5YWl5ZCOIEg1IHRhYiDnvJbovpEv5L+d5a2Y6YO96Lev55Sx5Yiw6K+l5Y+Y5L2TCmNvbnN0IHZhcmlhbnRFZGl0aW5nID0gcmVmKG51bGwpCi8vIOS/neWtmOi/m+WFpeWPmOS9k+aooeW8j+WJjeeahCBoNUZvcm0g5b+r54Wn77yM6YCA5Ye65pe25oGi5aSNCmNvbnN0IF9saXZlSDVCYWNrdXAgPSByZWYobnVsbCkKCmNvbnN0IGNvbmNsdWRlRGlhbG9nID0gcmVmKGZhbHNlKQpjb25zdCBjb25jbHVkZUZvcm0gPSByZWYoeyB3aW5uZXI6ICdCJywgbm90ZTogJycgfSkKCmZ1bmN0aW9uIGV4cFN0YXR1c1RhZyhzKSB7CiAgcmV0dXJuICh7IGRyYWZ0OiAnaW5mbycsIHJ1bm5pbmc6ICdzdWNjZXNzJywgc3RvcHBlZDogJ3dhcm5pbmcnLCBjb25jbHVkZWQ6ICcnIH0pW3NdIHx8ICdpbmZvJwp9CmZ1bmN0aW9uIGV4cFN0YXR1c0xhYmVsKHMpIHsKICByZXR1cm4gKHsgZHJhZnQ6ICfojYnnqL8nLCBydW5uaW5nOiAn6L+b6KGM5LitJywgc3RvcHBlZDogJ+W3suaaguWBnCcsIGNvbmNsdWRlZDogJ+W3sue7k+adnycgfSlbc10gfHwgcwp9CmZ1bmN0aW9uIHZhcmlhbnRTdGF0KGtleSkgewogIHJldHVybiBleHBTdGF0cy52YWx1ZT8udmFyaWFudHM/LmZpbmQodiA9PiB2LmtleSA9PT0ga2V5KQogICAgfHwgeyB2aXNpdHM6IDAsIHV2OiAwLCBjbGFpbXM6IDAsIHJlZGVlbXM6IDAsIGNsYWltX3JhdGU6IDAsIHJlZGVlbV9yYXRlOiAwIH0KfQpmdW5jdGlvbiBsZWFkZXJUYWcoa2V5KSB7CiAgaWYgKCFleHBTdGF0cy52YWx1ZT8uc2lnbmlmaWNhbmNlKSByZXR1cm4gJycKICByZXR1cm4gZXhwU3RhdHMudmFsdWUuc2lnbmlmaWNhbmNlLmxlYWRlciA9PT0ga2V5ID8gJ3N1Y2Nlc3MnIDogJ2luZm8nCn0KY29uc3QgYW55U2lnQ29uZmlkZW50ID0gY29tcHV0ZWQoKCkgPT4gewogIGNvbnN0IHNpZyA9IGV4cFN0YXRzLnZhbHVlPy5zaWduaWZpY2FuY2UKICBpZiAoIXNpZz8uY29tcGFyaXNvbnMpIHJldHVybiBmYWxzZQogIHJldHVybiBzaWcuY29tcGFyaXNvbnMuc29tZShjID0+IGMuY29uZmlkZW50KQp9KQoKYXN5bmMgZnVuY3Rpb24gbG9hZEV4cGVyaW1lbnQoKSB7CiAgdHJ5IHsKICAgIGNvbnN0IGRhdGEgPSBhd2FpdCBnZXRFeHBlcmltZW50KHByb2plY3RJZCkKICAgIGV4cGVyaW1lbnQudmFsdWUgPSBkYXRhLmV4aXN0cyA/IGRhdGEgOiBudWxsCiAgICBpZiAoZXhwZXJpbWVudC52YWx1ZSAmJiBleHBlcmltZW50LnZhbHVlLnN0YXR1cyA9PT0gJ3J1bm5pbmcnKSB7CiAgICAgIGV4cFN0YXRzLnZhbHVlID0gYXdhaXQgZ2V0RXhwZXJpbWVudFN0YXRzKHByb2plY3RJZCkuY2F0Y2goKCkgPT4gbnVsbCkKICAgIH0gZWxzZSBpZiAoZXhwZXJpbWVudC52YWx1ZSkgewogICAgICBleHBTdGF0cy52YWx1ZSA9IGF3YWl0IGdldEV4cGVyaW1lbnRTdGF0cyhwcm9qZWN0SWQpLmNhdGNoKCgpID0+IG51bGwpCiAgICB9IGVsc2UgewogICAgICBleHBTdGF0cy52YWx1ZSA9IG51bGwKICAgIH0KICB9IGNhdGNoIChlKSB7CiAgICBleHBlcmltZW50LnZhbHVlID0gbnVsbAogICAgZXhwU3RhdHMudmFsdWUgPSBudWxsCiAgfQp9CgpmdW5jdGlvbiBvcGVuQ3JlYXRlRXhwRGlhbG9nKCkgewogIG5ld0V4cC52YWx1ZSA9IHsKICAgIG5hbWU6ICdBL0Ig5a6e6aqMJywgaHlwb3RoZXNpczogJycsCiAgICB2YXJpYW50X2NvdW50OiAyLAogICAgdHJhZmZpY19zaGFyZXM6IFs1MCwgNTBdLAogIH0KICBjcmVhdGVFeHBEaWFsb2cudmFsdWUgPSB0cnVlCn0KCmFzeW5jIGZ1bmN0aW9uIGRvQ3JlYXRlRXhwKCkgewogIGV4cEFjdGluZy52YWx1ZSA9IHRydWUKICB0cnkgewogICAgYXdhaXQgY3JlYXRlRXhwZXJpbWVudChwcm9qZWN0SWQsIHsKICAgICAgbmFtZTogbmV3RXhwLnZhbHVlLm5hbWUsCiAgICAgIGh5cG90aGVzaXM6IG5ld0V4cC52YWx1ZS5oeXBvdGhlc2lzLAogICAgICB2YXJpYW50X2NvdW50OiBuZXdFeHAudmFsdWUudmFyaWFudF9jb3VudCwKICAgICAgdHJhZmZpY19zaGFyZXM6IG5ld0V4cC52YWx1ZS50cmFmZmljX3NoYXJlcywKICAgIH0pCiAgICBjcmVhdGVFeHBEaWFsb2cudmFsdWUgPSBmYWxzZQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoJ+WunumqjOW3suWIm+W7uu+8iOiNieeov+aAge+8ie+8jOeCueOAjOWQr+WKqOOAjeW8gOWni+WIhua1gScpCiAgICBhd2FpdCBsb2FkRXhwZXJpbWVudCgpCiAgfSBmaW5hbGx5IHsKICAgIGV4cEFjdGluZy52YWx1ZSA9IGZhbHNlCiAgfQp9Cgphc3luYyBmdW5jdGlvbiBleHBUcmFuc2l0aW9uKHRvKSB7CiAgZXhwQWN0aW5nLnZhbHVlID0gdHJ1ZQogIHRyeSB7CiAgICBhd2FpdCB0cmFuc2l0aW9uRXhwZXJpbWVudChwcm9qZWN0SWQsIHRvKQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoewogICAgICBydW5uaW5nOiAn5a6e6aqM5ZCv5Yqo77yM5oyJIDUwLzUwIOW8gOWni+WIhua1gScsCiAgICAgIHN0b3BwZWQ6ICflt7LmmoLlgZwnLAogICAgICBjb25jbHVkZWQ6ICflt7Lnu5PmoYgnLAogICAgfVt0b10gfHwgJ+W3suWIh+aNoicpCiAgICBhd2FpdCBsb2FkRXhwZXJpbWVudCgpCiAgfSBmaW5hbGx5IHsKICAgIGV4cEFjdGluZy52YWx1ZSA9IGZhbHNlCiAgfQp9Cgphc3luYyBmdW5jdGlvbiBkZWxldGVFeHAoKSB7CiAgdHJ5IHsKICAgIGF3YWl0IEVsTWVzc2FnZUJveC5jb25maXJtKCfnoa7orqTliKDpmaTor6Xlrp7pqozvvJ/miYDmnInlj5jkvZPmlbDmja7lsIbml6Dms5XmgaLlpI3vvIjorr/pl67orrDlvZXkv53nlZnvvInjgIInLCAn5Yig6Zmk5a6e6aqMJywgeyB0eXBlOiAnd2FybmluZycgfSkKICAgIGV4cEFjdGluZy52YWx1ZSA9IHRydWUKICAgIGF3YWl0IGRlbGV0ZUV4cGVyaW1lbnQocHJvamVjdElkKQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoJ+WunumqjOW3suWIoOmZpCcpCiAgICBhd2FpdCBsb2FkRXhwZXJpbWVudCgpCiAgfSBjYXRjaCAoZSkgewogICAgaWYgKGUgIT09ICdjYW5jZWwnKSB0aHJvdyBlCiAgfSBmaW5hbGx5IHsKICAgIGV4cEFjdGluZy52YWx1ZSA9IGZhbHNlCiAgfQp9CgovLyBQaGFzZSAyLjQg6L+b5YWl5Y+Y5L2T57yW6L6R5qih5byPCmZ1bmN0aW9uIGVudGVyVmFyaWFudEVkaXRpbmcodikgewogIGlmICghaDUudmFsdWUpIHJldHVybgogIC8vIOWkh+S7veW9k+WJjSBoNUZvcm3vvIjlpoLmnpzkuI3mmK/ku47lt7IgYmFja3VwIOeKtuaAgei/m+eahO+8iQogIGlmICghdmFyaWFudEVkaXRpbmcudmFsdWUpIHsKICAgIF9saXZlSDVCYWNrdXAudmFsdWUgPSBKU09OLnBhcnNlKEpTT04uc3RyaW5naWZ5KGg1Rm9ybS52YWx1ZSkpCiAgfQogIHZhcmlhbnRFZGl0aW5nLnZhbHVlID0geyBpZDogdi5pZCwga2V5OiB2LmtleSwgbmFtZTogdi5uYW1lIHx8ICcnIH0KICAvLyDnlKjlj5jkvZPnmoTlv6vnhafloavlhYUgaDVGb3JtCiAgY29uc3Qgc25hcCA9IHYuaDVfc25hcHNob3QgfHwge30KICBjb25zdCBtZXJnZWQgPSB7IC4uLihfbGl2ZUg1QmFja3VwLnZhbHVlIHx8IGg1Rm9ybS52YWx1ZSksIC4uLnNuYXAgfQogIC8vIHN1Ym1pdF9idXR0b24gLyBwcml2YWN5IC8gc3VjY2Vzc192aWV3IOetieW1jOWll+WvueixoemcgOimgea3seWQiOW5tuS7pemYsiBzbmFwIOe8uuWtl+auteaXtuS4ouWkseWOnyBiYXNlIOWtl+autQogIG1lcmdlZC5zdWJtaXRfYnV0dG9uID0geyAuLi4oX2xpdmVINUJhY2t1cC52YWx1ZT8uc3VibWl0X2J1dHRvbiB8fCB7fSksIC4uLihzbmFwLnN1Ym1pdF9idXR0b24gfHwge30pIH0KICBtZXJnZWQucHJpdmFjeSA9IHsgLi4uKF9saXZlSDVCYWNrdXAudmFsdWU/LnByaXZhY3kgfHwge30pLCAuLi4oc25hcC5wcml2YWN5IHx8IHt9KSB9CiAgbWVyZ2VkLnN1Y2Nlc3NfdmlldyA9IHsgLi4uKF9saXZlSDVCYWNrdXAudmFsdWU/LnN1Y2Nlc3NfdmlldyB8fCB7fSksIC4uLihzbmFwLnN1Y2Nlc3NfdmlldyB8fCB7fSkgfQogIGg1Rm9ybS52YWx1ZSA9IG1lcmdlZAogIGFjdGl2ZVRhYi52YWx1ZSA9ICdoNScKICBuZXh0VGljayhyZWZyZXNoUHJldmlldykKICBFbE1lc3NhZ2UuaW5mbyhg5bey6L+b5YWl5Y+Y5L2TICR7di5rZXl9IOe8lui+keaooeW8j++8jOaJgOacieS/neWtmOmDveWGmeWFpeivpeWPmOS9k+W/q+eFp2ApCn0KCmZ1bmN0aW9uIGV4aXRWYXJpYW50RWRpdGluZygpIHsKICB2YXJpYW50RWRpdGluZy52YWx1ZSA9IG51bGwKICAvLyDmgaLlpI0gbGl2ZSBINSDlhoXlrrkKICBpZiAoX2xpdmVINUJhY2t1cC52YWx1ZSkgewogICAgaDVGb3JtLnZhbHVlID0gX2xpdmVINUJhY2t1cC52YWx1ZQogICAgX2xpdmVINUJhY2t1cC52YWx1ZSA9IG51bGwKICB9IGVsc2UgaWYgKGg1LnZhbHVlKSB7CiAgICBzeW5jSDVGb3JtKGg1LnZhbHVlKQogIH0KICBuZXh0VGljayhyZWZyZXNoUHJldmlldykKfQoKZnVuY3Rpb24gb3BlbkNvbmNsdWRlRGlhbG9nKCkgewogIGNvbmNsdWRlRm9ybS52YWx1ZSA9IHsKICAgIHdpbm5lcjogZXhwU3RhdHMudmFsdWU/LnNpZ25pZmljYW5jZT8ubGVhZGVyIHx8ICdCJywKICAgIG5vdGU6ICcnLAogIH0KICBjb25jbHVkZURpYWxvZy52YWx1ZSA9IHRydWUKfQoKYXN5bmMgZnVuY3Rpb24gZG9Db25jbHVkZSgpIHsKICBleHBBY3RpbmcudmFsdWUgPSB0cnVlCiAgdHJ5IHsKICAgIGF3YWl0IHRyYW5zaXRpb25FeHBlcmltZW50KHByb2plY3RJZCwgJ2NvbmNsdWRlZCcsIGNvbmNsdWRlRm9ybS52YWx1ZSkKICAgIGNvbmNsdWRlRGlhbG9nLnZhbHVlID0gZmFsc2UKICAgIEVsTWVzc2FnZS5zdWNjZXNzKGDlrp7pqozlt7Lnu5PmoYjvvIzog5zlh7ogJHtjb25jbHVkZUZvcm0udmFsdWUud2lubmVyfeOAgkg1IOiNieeov+W3suW6lOeUqO+8jOivt+WIsCBINSB0YWIg5qOA5p+l5ZCO5Y+R5biDYCkKICAgIGF3YWl0IGxvYWRFeHBlcmltZW50KCkKICAgIC8vIOWIt+aWsCBINSDnirbmgIHvvIhiYXNlIOiiq+imhuebluS6hu+8iQogICAgaDUudmFsdWUgPSBhd2FpdCBnZXRQcm9qZWN0SDUocHJvamVjdElkKQogICAgc3luY0g1Rm9ybShoNS52YWx1ZSkKICB9IGZpbmFsbHkgewogICAgZXhwQWN0aW5nLnZhbHVlID0gZmFsc2UKICB9Cn0KCi8vIOeql+WPo+WwuuWvuOWPmOWMluaXtumHjee7mApmdW5jdGlvbiBvblJlc2l6ZSgpIHsKICB0cmVuZENoYXJ0Py5yZXNpemUoKQogIGZ1bm5lbENoYXJ0Py5yZXNpemUoKQp9CgovLyDpooTop4ggaWZyYW1lIOWPkeadpeeahOaLluaLveaOkuW6j+a2iOaBrwpmdW5jdGlvbiBvblByZXZpZXdNZXNzYWdlKGUpIHsKICAvLyBQaGFzZSAyLjU6IDk4ODQ4OWM4NTMzYTYyZDY2MmZkNGY0ZDdmNmU2NmY0NjViMAogIGlmIChlLmRhdGE/LnR5cGUgPT09ICdndXNoLXBvc2l0aW9uLXVwZGF0ZScpIHsKICAgIGNvbnN0IHsgZmllbGQsIHBvc2l0aW9uIH0gPSBlLmRhdGEKICAgIGlmIChhY3RpdmVUYWIudmFsdWUgIT09ICdoNScgfHwgdmFyaWFudEVkaXRpbmcudmFsdWUpIHJldHVybgogICAgaWYgKGZpZWxkID09PSAnaGVhZGVyX3Bvc2l0aW9uJykgaDVGb3JtLnZhbHVlLmhlYWRlcl9wb3NpdGlvbiA9IHsgLi4ucG9zaXRpb24gfQogICAgaWYgKGZpZWxkID09PSAnYnV0dG9uX3Bvc2l0aW9uJykgaDVGb3JtLnZhbHVlLmJ1dHRvbl9wb3NpdGlvbiA9IHsgLi4ucG9zaXRpb24gfQogICAgc2F2ZUg1X1NpbGVudCgpCiAgICByZXR1cm4KICB9CgogIGlmIChlLmRhdGE/LnR5cGUgIT09ICdndXNoLWJsb2NrLXJlb3JkZXInKSByZXR1cm4KICBjb25zdCB7IGZyb21JbmRleCwgdG9JbmRleCB9ID0gZS5kYXRhCiAgaWYgKGFjdGl2ZVRhYi52YWx1ZSAhPT0gJ2g1JyB8fCB2YXJpYW50RWRpdGluZy52YWx1ZSkgcmV0dXJuCiAgY29uc3QgYXJyID0gaDVGb3JtLnZhbHVlLmJsb2NrcwogIGlmIChmcm9tSW5kZXggPCAwIHx8IGZyb21JbmRleCA+PSBhcnIubGVuZ3RoIHx8IHRvSW5kZXggPCAwIHx8IHRvSW5kZXggPj0gYXJyLmxlbmd0aCkgcmV0dXJuCiAgY29uc3QgW2l0ZW1dID0gYXJyLnNwbGljZShmcm9tSW5kZXgsIDEpCiAgYXJyLnNwbGljZSh0b0luZGV4LCAwLCBpdGVtKQogIHNhdmVINV9TaWxlbnQoKQp9Cm9uTW91bnRlZCgoKSA9PiB7CiAgd2luZG93LmFkZEV2ZW50TGlzdGVuZXIoJ3Jlc2l6ZScsIG9uUmVzaXplKQogIC8vIOebkeWQrOmihOiniCBpZnJhbWUg5Y+R5p2l55qE5ouW5ou95o6S5bqP5raI5oGvCiAgd2luZG93LmFkZEV2ZW50TGlzdGVuZXIoJ21lc3NhZ2UnLCBvblByZXZpZXdNZXNzYWdlKQp9KQpvblVubW91bnRlZCgoKSA9PiB7CiAgd2luZG93LnJlbW92ZUV2ZW50TGlzdGVuZXIoJ3Jlc2l6ZScsIG9uUmVzaXplKQogIHdpbmRvdy5yZW1vdmVFdmVudExpc3RlbmVyKCdtZXNzYWdlJywgb25QcmV2aWV3TWVzc2FnZSkKICB0cmVuZENoYXJ0Py5kaXNwb3NlKCkKICBmdW5uZWxDaGFydD8uZGlzcG9zZSgpCn0pCgpvbk1vdW50ZWQobG9hZEFsbCkKPC9zY3JpcHQ+Cgo8c3R5bGUgc2NvcGVkPgoucGFnZS1lZGl0b3IgeyBkaXNwbGF5OiBmbGV4OyBmbGV4LWRpcmVjdGlvbjogY29sdW1uOyBnYXA6IDE0cHg7IH0KLmhkci1jYXJkIDpkZWVwKC5lbC1jYXJkX19ib2R5KSB7IGRpc3BsYXk6IG5vbmU7IH0KLmhkciB7IGRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiBjZW50ZXI7IGdhcDogMTJweDsgcGFkZGluZzogNHB4IDA7IH0KLmhkciAudGl0bGUgeyBmb250LXNpemU6IDE2cHg7IGZvbnQtd2VpZ2h0OiA2MDA7IH0KLmhkciAuc3BhY2VyIHsgZmxleDogMTsgfQoKLmVkaXRvci10YWJzIDpkZWVwKC5lbC10YWJzX19jb250ZW50KSB7IHBhZGRpbmctdG9wOiA4cHg7IH0KCi50aGVtZS1ncmlkIHsKICBkaXNwbGF5OiBncmlkOwogIGdyaWQtdGVtcGxhdGUtY29sdW1uczogcmVwZWF0KDIsIG1pbm1heCgwLCAxZnIpKTsKICBnYXA6IDE0cHg7Cn0KLmNmZy1jYXJkIHsgYm9yZGVyOiAxcHggc29saWQgdmFyKC0tZWwtYm9yZGVyLWNvbG9yLWxpZ2h0KTsgfQouY2FyZC10aXRsZSB7IGZvbnQtc2l6ZTogMTRweDsgZm9udC13ZWlnaHQ6IDYwMDsgfQouaGludCB7IGNvbG9yOiB2YXIoLS1lbC10ZXh0LWNvbG9yLXNlY29uZGFyeSk7IGZvbnQtc2l6ZTogMTJweDsgbWFyZ2luLWxlZnQ6IDEwcHg7IH0KCi5wcmV2aWV3LXN0YWdlIHsKICBib3JkZXItcmFkaXVzOiAxMnB4OwogIG1pbi1oZWlnaHQ6IDI0MHB4OwogIGRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiBjZW50ZXI7IGp1c3RpZnktY29udGVudDogY2VudGVyOwogIHBhZGRpbmc6IDMwcHg7Cn0KLnByZXZpZXctY2FyZC1pbm5lciB7IHRleHQtYWxpZ246IGNlbnRlcjsgfQoucGgtaDEgeyBmb250LXNpemU6IDI0cHg7IGZvbnQtd2VpZ2h0OiA3MDA7IH0KLnBoLXN1YiB7IGZvbnQtc2l6ZTogMTNweDsgbWFyZ2luOiA0cHggMCAxOHB4OyB9Ci5waC1idG4gewogIGRpc3BsYXk6IGlubGluZS1ibG9jazsgcGFkZGluZzogMTBweCAyOHB4OyBib3JkZXItcmFkaXVzOiAxMHB4OwogIGNvbG9yOiAjZmZmOyBmb250LXdlaWdodDogNjAwOyBmb250LXNpemU6IDE0cHg7Cn0KLnBoLWNvZGUgewogIG1hcmdpbi10b3A6IDE2cHg7IHBhZGRpbmc6IDEycHggMThweDsgZm9udC1mYW1pbHk6IHVpLW1vbm9zcGFjZSwgTWVubG8sIG1vbm9zcGFjZTsKICBmb250LXNpemU6IDIycHg7IGxldHRlci1zcGFjaW5nOiA2cHg7IGJvcmRlcjogMXB4IGRhc2hlZDsgYm9yZGVyLXJhZGl1czogOHB4OwogIGRpc3BsYXk6IGlubGluZS1ibG9jazsKfQoKLmZvb3Rlci1iYXIgewogIGRpc3BsYXk6IGZsZXg7IGp1c3RpZnktY29udGVudDogZmxleC1lbmQ7IGdhcDogMTBweDsKICBwYWRkaW5nLXRvcDogMTRweDsgbWFyZ2luLXRvcDogMTRweDsKICBib3JkZXItdG9wOiAxcHggc29saWQgdmFyKC0tZWwtYm9yZGVyLWNvbG9yLWxpZ2h0ZXIpOwp9CgpAbWVkaWEgKG1heC13aWR0aDogMTAwMHB4KSB7CiAgLnRoZW1lLWdyaWQgeyBncmlkLXRlbXBsYXRlLWNvbHVtbnM6IDFmcjsgfQp9CgovKiA9PT09PSBINSDnvJbovpHlmajluIPlsYAgPT09PT0gKi8KLmg1LWxheW91dCB7CiAgZGlzcGxheTogZ3JpZDsKICBncmlkLXRlbXBsYXRlLWNvbHVtbnM6IG1pbm1heCgwLCAxZnIpIDM4MHB4OwogIGdhcDogMTRweDsKICBhbGlnbi1pdGVtczogc3RhcnQ7Cn0KLmg1LWVkaXQtY29sIHsgZGlzcGxheTogZmxleDsgZmxleC1kaXJlY3Rpb246IGNvbHVtbjsgZ2FwOiAxNHB4OyB9Ci5oNS1wcmV2aWV3LWNvbCB7IHBvc2l0aW9uOiBzdGlja3k7IHRvcDogMTRweDsgfQoKLmhkci1zcGFjZXIgeyBmbGV4OiAxOyB9Ci5jZmctY2FyZCA6ZGVlcCguZWwtY2FyZF9faGVhZGVyKSB7IGRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiBjZW50ZXI7IGdhcDogMTBweDsgfQouY2ZnLWNhcmQgOmRlZXAoLmVsLWNhcmRfX2hlYWRlcikgLmNhcmQtdGl0bGUgeyBmbGV4LXNocmluazogMDsgfQoKLml0ZW0tbGlzdCB7IGRpc3BsYXk6IGZsZXg7IGZsZXgtZGlyZWN0aW9uOiBjb2x1bW47IGdhcDogOHB4OyB9Ci5pdGVtLXJvdyB7CiAgZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IGNlbnRlcjsgZ2FwOiA4cHg7CiAgcGFkZGluZzogMTBweCAxMnB4OwogIGJhY2tncm91bmQ6IHZhcigtLWVsLWZpbGwtY29sb3ItbGlnaHQpOwogIGJvcmRlci1yYWRpdXM6IDhweDsKICBib3JkZXI6IDFweCBzb2xpZCB2YXIoLS1lbC1ib3JkZXItY29sb3ItbGlnaHRlcik7CiAgY3Vyc29yOiBncmFiOwogIHRyYW5zaXRpb246IGJvcmRlci1jb2xvciAuMnMsIGJhY2tncm91bmQgLjJzOwp9Ci5pdGVtLXJvd1tkcmFnZ2FibGU9InRydWUiXTphY3RpdmUgeyBjdXJzb3I6IGdyYWJiaW5nOyB9Ci5pdGVtLXJvdy5pcy1kcmFnLW92ZXIgewogIGJvcmRlci1jb2xvcjogdmFyKC0tZWwtY29sb3ItcHJpbWFyeSk7CiAgYmFja2dyb3VuZDogdmFyKC0tZWwtY29sb3ItcHJpbWFyeS1saWdodC05KTsKfQouZHJhZy1oYW5kbGUgewogIGZsZXgtc2hyaW5rOiAwOyBjdXJzb3I6IGdyYWI7IGZvbnQtc2l6ZTogMThweDsKICBjb2xvcjogdmFyKC0tZWwtdGV4dC1jb2xvci1wbGFjZWhvbGRlcik7IGxpbmUtaGVpZ2h0OiAxOwogIHVzZXItc2VsZWN0OiBub25lOyBwYWRkaW5nOiAwIDJweDsKfQouZHJhZy1oYW5kbGU6YWN0aXZlIHsgY3Vyc29yOiBncmFiYmluZzsgfQouaXRlbS1pbmZvIHsKICBmbGV4OiAxOyBtaW4td2lkdGg6IDA7CiAgZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IGNlbnRlcjsgZ2FwOiA4cHg7Cn0KLml0ZW0tc3VtbWFyeSB7CiAgZm9udC1zaXplOiAxM3B4OyBjb2xvcjogdmFyKC0tZWwtdGV4dC1jb2xvci1yZWd1bGFyKTsKICBvdmVyZmxvdzogaGlkZGVuOyB0ZXh0LW92ZXJmbG93OiBlbGxpcHNpczsgd2hpdGUtc3BhY2U6IG5vd3JhcDsKfQoua2V5LXRhZyB7CiAgYmFja2dyb3VuZDogdmFyKC0tZWwtY29sb3ItaW5mby1saWdodC04KTsKICBjb2xvcjogdmFyKC0tZWwtY29sb3ItaW5mbyk7CiAgcGFkZGluZzogMXB4IDZweDsgYm9yZGVyLXJhZGl1czogNHB4OwogIGZvbnQtZmFtaWx5OiB1aS1tb25vc3BhY2UsIE1lbmxvLCBtb25vc3BhY2U7IGZvbnQtc2l6ZTogMTFweDsKfQoucmVxLW1pbmkgeyBjb2xvcjogdmFyKC0tZWwtY29sb3ItZGFuZ2VyKTsgZm9udC1zaXplOiAxMXB4OyB9Ci5pdGVtLWFjdGlvbnMgeyBmbGV4LXNocmluazogMDsgfQoKLm9wdC1yb3cgeyBkaXNwbGF5OiBmbGV4OyBnYXA6IDhweDsgYWxpZ24taXRlbXM6IGNlbnRlcjsgbWFyZ2luLWJvdHRvbTogOHB4OyB9Ci5vcHQtcm93IC5lbC1pbnB1dCB7IGZsZXg6IDE7IH0KCi8qIGlmcmFtZSDpooTop4ggKi8KLnByZXZpZXctZnJhbWUtd3JhcCB7CiAgYmFja2dyb3VuZDogdmFyKC0tZWwtYmctY29sb3IpOwogIGJvcmRlcjogMXB4IHNvbGlkIHZhcigtLWVsLWJvcmRlci1jb2xvci1saWdodCk7CiAgYm9yZGVyLXJhZGl1czogMTJweDsKICBwYWRkaW5nOiAxMnB4Owp9Ci5wcmV2aWV3LXRvb2xiYXIgewogIGRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiBjZW50ZXI7IGdhcDogOHB4OwogIHBhZGRpbmctYm90dG9tOiAxMHB4OwogIGJvcmRlci1ib3R0b206IDFweCBzb2xpZCB2YXIoLS1lbC1ib3JkZXItY29sb3ItbGlnaHRlcik7CiAgbWFyZ2luLWJvdHRvbTogMTBweDsKfQoucGhvbmUtZnJhbWUgewogIHdpZHRoOiAxMDAlOwogIGFzcGVjdC1yYXRpbzogOSAvIDE2OwogIGJvcmRlcjogOHB4IHNvbGlkICMxYTFhMWE7CiAgYm9yZGVyLXJhZGl1czogMjhweDsKICBvdmVyZmxvdzogaGlkZGVuOwogIGJhY2tncm91bmQ6ICMwMDA7CiAgYm94LXNoYWRvdzogMCA0cHggMjBweCByZ2JhKDAsMCwwLDAuMyk7Cn0KLnBob25lLWlmcmFtZSB7IHdpZHRoOiAxMDAlOyBoZWlnaHQ6IDEwMCU7IGJvcmRlcjogMDsgZGlzcGxheTogYmxvY2s7IGJhY2tncm91bmQ6ICMwYTBhMGE7IH0KLnByZXZpZXctaGludCB7CiAgZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IGNlbnRlcjsgZ2FwOiA2cHg7CiAgbWFyZ2luLXRvcDogMTBweDsKICBjb2xvcjogdmFyKC0tZWwtdGV4dC1jb2xvci1zZWNvbmRhcnkpOwogIGZvbnQtc2l6ZTogMTJweDsKfQoKQG1lZGlhIChtYXgtd2lkdGg6IDExMDBweCkgewogIC5oNS1sYXlvdXQgeyBncmlkLXRlbXBsYXRlLWNvbHVtbnM6IDFmcjsgfQogIC5oNS1wcmV2aWV3LWNvbCB7IHBvc2l0aW9uOiBzdGF0aWM7IH0KICAucGhvbmUtZnJhbWUgeyBtYXgtd2lkdGg6IDM2MHB4OyBtYXJnaW46IDAgYXV0bzsgfQp9CgovKiA9PT09PSBMRUQg57yW6L6R5Zmo5biD5bGAID09PT09ICovCi5sZWQtbGF5b3V0IHsKICBkaXNwbGF5OiBncmlkOwogIGdyaWQtdGVtcGxhdGUtY29sdW1uczogbWlubWF4KDAsIDFmcikgNTIwcHg7CiAgZ2FwOiAxNHB4OwogIGFsaWduLWl0ZW1zOiBzdGFydDsKfQoubGVkLWVkaXQtY29sIHsgZGlzcGxheTogZmxleDsgZmxleC1kaXJlY3Rpb246IGNvbHVtbjsgZ2FwOiAxNHB4OyB9Ci5sZWQtcHJldmlldy1jb2wgeyBwb3NpdGlvbjogc3RpY2t5OyB0b3A6IDE0cHg7IH0KCi5kdXJhdGlvbi10YWcgewogIGJhY2tncm91bmQ6IHZhcigtLWVsLWNvbG9yLXByaW1hcnktbGlnaHQtOSk7CiAgY29sb3I6IHZhcigtLWVsLWNvbG9yLXByaW1hcnkpOwogIHBhZGRpbmc6IDJweCA4cHg7IGJvcmRlci1yYWRpdXM6IDk5OXB4OwogIGZvbnQtc2l6ZTogMTFweDsgZm9udC1mYW1pbHk6IHVpLW1vbm9zcGFjZSwgTWVubG8sIG1vbm9zcGFjZTsKfQoKLmxlZC1mcmFtZSB7CiAgd2lkdGg6IDEwMCU7CiAgbWF4LXdpZHRoOiA0MjBweDsKICBhc3BlY3QtcmF0aW86IDkgLyAxNjsKICBib3JkZXI6IDZweCBzb2xpZCAjMWExYTFhOwogIGJvcmRlci1yYWRpdXM6IDEycHg7CiAgb3ZlcmZsb3c6IGhpZGRlbjsKICBiYWNrZ3JvdW5kOiAjMDAwOwogIGJveC1zaGFkb3c6IDAgNHB4IDIwcHggcmdiYSgwLDAsMCwwLjMpOwp9Ci5sZWQtaWZyYW1lIHsgd2lkdGg6IDEwMCU7IGhlaWdodDogMTAwJTsgYm9yZGVyOiAwOyBkaXNwbGF5OiBibG9jazsgYmFja2dyb3VuZDogIzBhMGEwYTsgfQoKQG1lZGlhIChtYXgtd2lkdGg6IDEyMDBweCkgewogIC5sZWQtbGF5b3V0IHsgZ3JpZC10ZW1wbGF0ZS1jb2x1bW5zOiAxZnI7IH0KICAubGVkLXByZXZpZXctY29sIHsgcG9zaXRpb246IHN0YXRpYzsgfQp9CgovKiA9PT09PSBQaGFzZSAyLjIg5pWw5o2u55yL5p2/ID09PT09ICovCi5zdGF0cy10b29sYmFyIHsKICBkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogY2VudGVyOyBnYXA6IDEwcHg7CiAgbWFyZ2luLWJvdHRvbTogMTRweDsKfQoua3BpLWdyaWQgewogIGRpc3BsYXk6IGdyaWQ7CiAgZ3JpZC10ZW1wbGF0ZS1jb2x1bW5zOiByZXBlYXQoNSwgbWlubWF4KDAsIDFmcikpOwogIGdhcDogMTJweDsKfQoua3BpLWNhcmQgewogIGJhY2tncm91bmQ6IHZhcigtLWVsLWJnLWNvbG9yKTsKICBib3JkZXI6IDFweCBzb2xpZCB2YXIoLS1lbC1ib3JkZXItY29sb3ItbGlnaHQpOwogIGJvcmRlci1yYWRpdXM6IDEwcHg7CiAgcGFkZGluZzogMTZweCAxOHB4Owp9Ci5rcGktY2FyZC5zdWNjZXNzIHsgYm9yZGVyLWxlZnQ6IDRweCBzb2xpZCB2YXIoLS1lbC1jb2xvci1zdWNjZXNzKTsgfQoua3BpLWNhcmQud2FybmluZyB7IGJvcmRlci1sZWZ0OiA0cHggc29saWQgdmFyKC0tZWwtY29sb3Itd2FybmluZyk7IH0KLmtwaS1jYXJkLnByaW1hcnkgeyBib3JkZXItbGVmdDogNHB4IHNvbGlkIHZhcigtLWVsLWNvbG9yLXByaW1hcnkpOyB9Ci5rcGktbGFiZWwgeyBjb2xvcjogdmFyKC0tZWwtdGV4dC1jb2xvci1zZWNvbmRhcnkpOyBmb250LXNpemU6IDEzcHg7IH0KLmtwaS12YWx1ZSB7IGZvbnQtc2l6ZTogMjhweDsgZm9udC13ZWlnaHQ6IDcwMDsgY29sb3I6IHZhcigtLWVsLXRleHQtY29sb3ItcHJpbWFyeSk7IG1hcmdpbi10b3A6IDRweDsgbGluZS1oZWlnaHQ6IDEuMjsgfQoua3BpLXN1YiB7IGNvbG9yOiB2YXIoLS1lbC10ZXh0LWNvbG9yLXNlY29uZGFyeSk7IGZvbnQtc2l6ZTogMTJweDsgbWFyZ2luLXRvcDogNHB4OyB9CgpAbWVkaWEgKG1heC13aWR0aDogMTEwMHB4KSB7CiAgLmtwaS1ncmlkIHsgZ3JpZC10ZW1wbGF0ZS1jb2x1bW5zOiByZXBlYXQoMiwgMWZyKTsgfQp9CgovKiA9PT09PSBQaGFzZSAyLjMgQS9CIOWunumqjCA9PT09PSAqLwoudmFyaWFudHMtZ3JpZCB7CiAgZGlzcGxheTogZ3JpZDsKICBncmlkLXRlbXBsYXRlLWNvbHVtbnM6IHJlcGVhdChhdXRvLWZpdCwgbWlubWF4KDI4MHB4LCAxZnIpKTsKICBnYXA6IDE0cHg7CiAgbWFyZ2luLXRvcDogMTRweDsKfQoudmFyaWFudC1jYXJkIHsgYm9yZGVyOiAxcHggc29saWQgdmFyKC0tZWwtYm9yZGVyLWNvbG9yLWxpZ2h0KTsgfQoKLnNoYXJlcy1ncmlkIHsgZGlzcGxheTogZmxleDsgZ2FwOiAxMnB4OyBmbGV4LXdyYXA6IHdyYXA7IG1hcmdpbi1ib3R0b206IDZweDsgfQouc2hhcmUtY2VsbCB7IGRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiBjZW50ZXI7IGdhcDogNHB4OyB9Ci5zaGFyZS10YWcgewogIGRpc3BsYXk6IGlubGluZS1ibG9jazsgbWFyZ2luLXJpZ2h0OiAxNHB4OwogIGZvbnQtZmFtaWx5OiB1aS1tb25vc3BhY2UsIE1lbmxvLCBtb25vc3BhY2U7IGZvbnQtc2l6ZTogMTNweDsKfQouc2hhcmUtbGFiZWwgewogIGJhY2tncm91bmQ6IHZhcigtLWVsLWNvbG9yLXByaW1hcnktbGlnaHQtOSk7IGNvbG9yOiB2YXIoLS1lbC1jb2xvci1wcmltYXJ5KTsKICBmb250LXdlaWdodDogNjAwOyB3aWR0aDogMjRweDsgaGVpZ2h0OiAyNHB4OwogIGJvcmRlci1yYWRpdXM6IDRweDsgdGV4dC1hbGlnbjogY2VudGVyOyBsaW5lLWhlaWdodDogMjRweDsKfQouc2hhcmUtcGN0IHsgY29sb3I6IHZhcigtLWVsLXRleHQtY29sb3Itc2Vjb25kYXJ5KTsgZm9udC1zaXplOiAxMnB4OyB9CgpAbWVkaWEgKG1heC13aWR0aDogOTAwcHgpIHsKICAudmFyaWFudHMtZ3JpZCB7IGdyaWQtdGVtcGxhdGUtY29sdW1uczogMWZyOyB9Cn0KCi8qID09PT09PT09PT09PSBQaGFzZSA1Lng6IOmihOiniOWFqOWxjyAvIOWkp+WwuuWvuOWIh+aNoiA9PT09PT09PT09PT0gKi8KLnByZXZpZXctc3RhZ2UtaDUgewogIGRpc3BsYXk6IGZsZXg7CiAganVzdGlmeS1jb250ZW50OiBjZW50ZXI7CiAgYWxpZ24taXRlbXM6IGZsZXgtc3RhcnQ7Cn0KLnByZXZpZXctc3RhZ2UtaDUubW9kZS1waG9uZSAucGhvbmUtZnJhbWUgewogIHdpZHRoOiAxMDAlOwogIG1heC13aWR0aDogMzgwcHg7CiAgYXNwZWN0LXJhdGlvOiA5IC8gMTY7Cn0KLnByZXZpZXctc3RhZ2UtaDUubW9kZS1mdWxsIC5waG9uZS1mcmFtZSB7CiAgd2lkdGg6IDEwMCU7CiAgbWF4LXdpZHRoOiA0ODBweDsKICBoZWlnaHQ6IGNhbGMoMTAwdmggLSAyODBweCk7CiAgbWluLWhlaWdodDogNTIwcHg7CiAgYXNwZWN0LXJhdGlvOiBhdXRvOwogIGJvcmRlci1yYWRpdXM6IDEycHg7CiAgYm9yZGVyLXdpZHRoOiAzcHg7Cn0KLnByZXZpZXctZnJhbWUtd3JhcC5pcy1mdWxsc2NyZWVuIHsKICBwb3NpdGlvbjogZml4ZWQ7CiAgaW5zZXQ6IDA7CiAgei1pbmRleDogMjAwMDsKICBib3JkZXI6IG5vbmU7CiAgYm9yZGVyLXJhZGl1czogMDsKICBwYWRkaW5nOiAxNnB4IDIwcHg7CiAgYmFja2dyb3VuZDogdmFyKC0tZWwtYmctY29sb3ItcGFnZSk7CiAgb3ZlcmZsb3c6IGF1dG87Cn0KLnByZXZpZXctZnJhbWUtd3JhcC5pcy1mdWxsc2NyZWVuIC5wcmV2aWV3LXN0YWdlLWg1Lm1vZGUtcGhvbmUgLnBob25lLWZyYW1lIHsKICBtYXgtd2lkdGg6IDQyMHB4OwogIGhlaWdodDogY2FsYygxMDB2aCAtIDEwMHB4KTsKICBhc3BlY3QtcmF0aW86IDkgLyAxNjsKfQoucHJldmlldy1mcmFtZS13cmFwLmlzLWZ1bGxzY3JlZW4gLnByZXZpZXctc3RhZ2UtaDUubW9kZS1mdWxsIC5waG9uZS1mcmFtZSB7CiAgbWF4LXdpZHRoOiBub25lOwogIHdpZHRoOiBjYWxjKDEwMHZ3IC0gODBweCk7CiAgaGVpZ2h0OiBjYWxjKDEwMHZoIC0gMTAwcHgpOwogIGFzcGVjdC1yYXRpbzogYXV0bzsKfQo8L3N0eWxlPgo=
B64EOF

ls -la /tmp/PageEditor.vue.new.b64 2>&1; echo ---decode---; base64 -d /tmp/PageEditor.vue.new.b64 > /tmp/PageEditor.vue.new 2>&1; ls -la /tmp/PageEditor.vue.new 2>&1; md5sum /tmp/PageEditor.vue.new 2>&1; echo ---online_md5---; md5sum /opt/gush2/frontend/src/views/projects/PageEditor.vue 2>&1; exit
cp /opt/gush2/frontend/src/views/projects/PageEditor.vue /home/ubuntu/gush2-snapshots/20260602-222329/PageEditor.vue.online.bak && cp /tmp/PageEditor.vue.new /opt/gush2/frontend/src/views/projects/PageEditor.vue && echo ---mtime_after--- && ls -la /opt/gush2/frontend/src/views/projects/PageEditor.vue && md5sum /opt/gush2/frontend/src/views/projects/PageEditor.vue && echo ---cd_build--- && cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build nginx 2>&1 | tail -30
sudo docker images gush2-nginx --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}" 2>&1 && echo ---restart--- && sudo docker compose -f /opt/gush2/docker-compose.prod.yml --env-file /opt/gush2/.env.prod up -d nginx 2>&1 | tail -10 && echo ---ps--- && sudo docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>&1 | grep -E "nginx|backend" && exit
cat > /tmp/verify.sh << 'REMOTE_EOF'
echo ---sleep---
sleep 8
sudo docker ps --format 'table {{.Names}}{{.Status}}'
echo ---curl_https---
curl -sk -o /dev/null -w 'admin=%{http_code} time=%{time_total}\n' https://admin.gush.cdgushai.com/
curl -sk -o /dev/null -w 'root=%{http_code} time=%{time_total}\n' https://gush.cdgushai.com/
curl -sk -o /dev/null -w 'm1=%{http_code} time=%{time_total}\n' https://machine001.gush.cdgushai.com/
echo ---index_html_index_js---
INDEX=$(curl -sk https://admin.gush.cdgushai.com/ | grep -oE 'assets/index-[A-Za-z0-9_-]+\.js' | head -1)
echo "INDEX=$INDEX"
echo ---grep_bundle---
curl -sk "https://admin.gush.cdgushai.com/$INDEX" | grep -oE '(姓名|年龄|请输入姓名|请输入年龄|请输入正确的年龄)' | sort -u
echo ---backend---
curl -sk -o /dev/null -w 'api_health=%{http_code}\n' https://admin.gush.cdgushai.com/api/health
echo ---END---
REMOTE_EOF

cat > /tmp/verify.sh << 'REMOTE_EOF'
echo ---sleep---
sleep 8
sudo docker ps --format 'table {{.Names}}{{.Status}}'
echo ---curl_https---
curl -sk -o /dev/null -w 'admin=%{http_code} time=%{time_total}\n' https://admin.gush.cdgushai.com/
curl -sk -o /dev/null -w 'root=%{http_code} time=%{time_total}\n' https://gush.cdgushai.com/
curl -sk -o /dev/null -w 'm1=%{http_code} time=%{time_total}\n' https://machine001.gush.cdgushai.com/
echo ---index_html_index_js---
INDEX=$(curl -sk https://admin.gush.cdgushai.com/ | grep -oE 'assets/index-[A-Za-z0-9_-]+\.js' | head -1)
echo "INDEX=$INDEX"
echo ---grep_bundle---
curl -sk "https://admin.gush.cdgushai.com/$INDEX" | grep -oE '(姓名|年龄|请输入姓名|请输入年龄|请输入正确的年龄)' | sort -u
echo ---backend---
curl -sk -o /dev/null -w 'api_health=%{http_code}\n' https://admin.gush.cdgushai.com/api/health
echo ---END---
REMOTE_EOF

bash /tmp/verify.sh; echo MARKER_END_OF_VERIFY
cat > /tmp/verify2.sh << 'REMOTE_EOF'
echo ---headers---
curl -skI https://admin.gush.cdgushai.com/assets/index-BeFkvOCL.js | head -10
echo ---decompressed---
curl -sk --compressed https://admin.gush.cdgushai.com/assets/index-BeFkvOCL.js -o /tmp/bundle.js
ls -la /tmp/bundle.js
echo ---grep---
grep -oE '(姓名|年龄|请输入姓名|请输入年龄|请输入正确的年龄|新增字段|添加字段)' /tmp/bundle.js | sort -u
echo ---END---
REMOTE_EOF

bash /tmp/verify2.sh; echo MARKER_END2
exit
cat > /tmp/verify3.sh << 'REMOTE_EOF'
echo ---decode_unicode_escape---
# Vue 编译后中文字符串会变 姓名 ，把它们解码后再 grep
python3 -c "
import re
data = open('/tmp/bundle.js', 'rb').read().decode('utf-8', errors='ignore')
# 提取所有 \u 转义
out = re.sub(r'\\\\u([0-9a-fA-F]{4})', lambda m: chr(int(m.group(1), 16)), data)
open('/tmp/bundle.d.js', 'w', encoding='utf-8').write(out)
print('OK', len(out))
"
echo ---grep_decoded---
grep -oE '(姓名|年龄|请输入姓名|请输入年龄|请输入正确的年龄|添加字段)' /tmp/bundle.d.js | sort -u
echo ---grep_escaped---
grep -oE '(\\\\u59d3\\\\u540d|\\\\u5e74\\\\u9f84|\\\\u8bf7\\\\u8f93\\\\u5165\\\\u59d3\\\\u540d|\\\\u8bf7\\\\u8f93\\\\u5165\\\\u5e74\\\\u9f84)' /tmp/bundle.js | sort -u | head -10
echo ---END---
REMOTE_EOF

bash /tmp/verify3.sh; echo MARKER_END3
exit
cat > /tmp/verify4.sh << 'REMOTE_EOF'
python3 << 'PYEOF'
import re
data = open('/tmp/bundle.js', 'rb').read().decode('utf-8', errors='ignore')
# unquote, replace surrogate pair artifacts
out = re.sub(r'\\u([0-9a-fA-F]{4})', lambda m: chr(int(m.group(1), 16)), data)
# 移除 surrogate
out = re.sub(r'[\\ud800-\\udfff]', '', out)
open('/tmp/bundle.d.js', 'w', encoding='utf-8', errors='ignore').write(out)
print('OK size=', len(out))
PYEOF
echo ---grep_decoded---
grep -aoE '(姓名|年龄|请输入姓名|请输入年龄|请输入正确的年龄|添加字段|新增字段|新字段)' /tmp/bundle.d.js | sort | uniq -c | head
echo ---END---
REMOTE_EOF

bash /tmp/verify4.sh; echo MARKER_END4
exit
echo ---on_server_PageEditor---; grep -nE "(command=\"name\"|command=\"age\"|f.label = .姓名|f.label = .年龄|f.placeholder = .请输入姓名|请输入年龄|请输入正确的年龄|\.name: .姓名|name: .姓名|name: .年龄)" /opt/gush2/frontend/src/views/projects/PageEditor.vue 2>&1; echo ---file_count---; ls /opt/gush2/frontend/src/views/projects/PageEditor.vue* 2>&1; echo ---inside_container_PageEditor---; sudo docker exec gush2-nginx sh -c "ls /usr/share/nginx/html/assets/ | head -5; echo --; grep -c 添加字段 /usr/share/nginx/html/assets/index-*.js 2>&1" 2>&1; exit
cat > /tmp/verify5.sh << 'REMOTE_EOF'
sudo docker exec gush2-nginx sh -c '
cd /usr/share/nginx/html/assets
echo ---all_js---
ls -la *.js | head -30
echo ---grep_addfield---
for f in *.js; do
  c=$(grep -c "添加字段" "$f" 2>/dev/null || echo 0)
  if [ "$c" != "0" ]; then echo "$f: $c"; fi
done
echo ---grep_decoded_index---
for f in index-*.js; do
  python3 -c "
import re
d = open(\"/usr/share/nginx/html/assets/$f\", encoding=\"utf-8\", errors=\"ignore\").read()
d = re.sub(r\"\\\\\\\\u([0-9a-fA-F]{4})\", lambda m: chr(int(m.group(1), 16)), d)
d = re.sub(r\"[\\ud800-\\udfff]\", \"\", d)
print(\"$f\", \"size=\", len(d), \"添加字段=\", d.count(\"添加字段\"), \"姓名=\", d.count(\"姓名\"), \"年龄=\", d.count(\"年龄\"), \"性别=\", d.count(\"性别\"))
"
done
echo ---END---
'
REMOTE_EOF

bash /tmp/verify5.sh; echo MARKER_END5
cat > /tmp/verify6.sh << 'REMOTE_EOF'
echo ---PageEditor_chunk_strings---
sudo docker exec gush2-nginx sh -c '
cd /usr/share/nginx/html/assets
python3 -c "
import re
d = open(\"PageEditor-Bncnpf3U.js\", encoding=\"utf-8\", errors=\"ignore\").read()
d2 = re.sub(r\"\\\\\\\\u([0-9a-fA-F]{4})\", lambda m: chr(int(m.group(1), 16)), d)
d2 = re.sub(r\"[\\ud800-\\udfff]\", \"\", d2)
for kw in [\"添加字段\", \"姓名\", \"年龄\", \"性别\", \"请输入姓名\", \"请输入年龄\", \"请输入正确的年龄\", \"新字段\", \"手机号\", \"多选\"]:
    print(kw, \"=\", d2.count(kw))
print(\"size=\", len(d), \"decoded=\", len(d2))
"
'
echo ---END---
REMOTE_EOF

bash /tmp/verify6.sh; echo MARKER_END6
cat > /tmp/verify7.sh << 'REMOTE_EOF'
echo ---raw_bytes---
sudo docker exec gush2-nginx sh -c '
cd /usr/share/nginx/html/assets
# 姓名 = 姓名   年龄 = 年龄   请输入姓名 = 请输入姓名
# 请输入年龄 = 请输入年龄   请输入正确的年龄 = 请输入正确的年龄
# 添加字段 = 添加字段   新字段 = 新字段
for kw in "添加字段" "姓名" "年龄" "性别" "多选" "手机号" "新字段" "请输入姓名" "请输入年龄" "请输入正确的年龄"; do
  echo -n "$kw = "
  cat PageEditor-Bncnpf3U.js | tr -d "\n" | grep -o "$kw" | wc -l
done
'
echo ---END---
REMOTE_EOF

bash /tmp/verify7.sh; echo MARKER_END7
cat > /tmp/diag500.sh << 'REMOTE_EOF'
echo ---A.nginx_500_recent---
sudo docker logs --tail 200 gush2-nginx 2>&1 | grep -E " 500 | 5[0-9][0-9] " | tail -30
echo ---B.backend_recent---
sudo docker logs --tail 300 gush2-backend 2>&1 | tail -120
echo ---C.nginx_error---
sudo docker exec gush2-nginx sh -c 'tail -100 /var/log/nginx/error.log 2>/dev/null; ls /var/log/nginx/ 2>/dev/null'
echo ---D.tracelog---
sudo docker exec gush2-backend sh -c 'ls /app/*.log 2>/dev/null; tail -200 /app/backend.log 2>/dev/null' 2>&1 | tail -50
echo ---END---
REMOTE_EOF

bash /tmp/diag500.sh; echo MARKER_END_DIAG
cat > /tmp/diag2.sh << 'REMOTE_EOF'
echo ---A.gush_project_columns---
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "DESCRIBE gush_project;" 2>&1 | grep -v Warning
echo ---B.grep_code_validity_days_in_backend---
grep -rn "code_validity_days" /opt/gush2/backend/ 2>&1 | head -20
echo ---C.migration_files---
ls /opt/gush2/backend/apps/projects/migrations/ 2>&1
echo ---D.unapplied_migrations---
sudo docker exec gush2-backend sh -c "cd /app && python manage.py showmigrations projects 2>&1" 2>&1 | tail -30
echo ---E.Project_model_def---
grep -nE "code_validity_days|class Project" /opt/gush2/backend/apps/projects/models.py 2>&1
echo ---END---
REMOTE_EOF

bash /tmp/diag2.sh; echo MARKER_END_DIAG2
exit
cat > /tmp/fix500.sh << 'REMOTE_EOF'
echo ---A.before---
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SHOW COLUMNS FROM gush_project LIKE 'code_validity_days';" 2>&1 | grep -v Warning
echo ---B.alter---
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "ALTER TABLE gush_project ADD COLUMN code_validity_days INT NOT NULL DEFAULT 7 AFTER code_validity_seconds; UPDATE gush_project SET code_validity_days = GREATEST(1, CEIL(code_validity_seconds/86400)) WHERE code_validity_seconds > 0 AND code_validity_days = 7;" 2>&1 | grep -v Warning
echo ---C.after---
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SHOW COLUMNS FROM gush_project LIKE 'code_validity%'; SELECT id, name, code_validity_seconds, code_validity_days FROM gush_project;" 2>&1 | grep -v Warning
echo ---D.curl_verify---
curl -sk -o /dev/null -w 'projects=%{http_code} time=%{time_total}\n' https://admin.gush.cdgushai.com/api/projects/projects/
curl -sk -o /dev/null -w 'machines=%{http_code} time=%{time_total}\n' https://admin.gush.cdgushai.com/api/devices/machines/
curl -sk -o /dev/null -w 'preview=%{http_code} time=%{time_total}\n' 'https://admin.gush.cdgushai.com/p/2/?preview=1&page=page1&_=1'
echo ---E.backend_log_tail---
sudo docker logs --tail 20 gush2-backend 2>&1 | tail -10
echo ---END---
REMOTE_EOF

bash /tmp/fix500.sh; echo MARKER_END_FIX
exit
cat > /tmp/redeemcheck.sh << 'REMOTE_EOF'
echo ---A.url_routes---
grep -nE "redeem.code|RedeemCode|redeem-code" /opt/gush2/backend/gush/urls.py 2>&1 | head -20
echo ---B.views_class---
grep -nE "RedeemCode|class.*Redeem|def destroy|def delete" /opt/gush2/backend/apps/projects/views.py 2>&1 | head -30
echo ---C.urls_app---
ls /opt/gush2/backend/apps/projects/urls*.py 2>&1
cat /opt/gush2/backend/apps/projects/urls.py 2>&1 | head -40
echo ---D.serializer_has_delete---
grep -nE "RedeemCode|class.*Redeem" /opt/gush2/backend/apps/projects/serializers.py 2>&1 | head -20
echo ---E.model_method---
grep -nE "class RedeemCode|def delete" /opt/gush2/backend/apps/projects/models.py 2>&1
echo ---END---
REMOTE_EOF

bash /tmp/redeemcheck.sh; echo MARKER_END_RC
exit
cat > /tmp/readv.sh << 'REMOTE_EOF'
echo ---A.views.py_imports---
sed -n '1,30p' /opt/gush2/backend/apps/projects/views.py
echo ---B.viewset_class---
sed -n '283,335p' /opt/gush2/backend/apps/projects/views.py
echo ---C.check_op_log_model---
find /opt/gush2/backend -path '*/operations/models.py' -exec head -30 {} \; 2>&1 | head -40
echo ---D.OperationLog_class---
grep -nE "class OperationLog" /opt/gush2/backend/apps/operations/models.py 2>&1
echo ---END---
REMOTE_EOF

bash /tmp/readv.sh; echo MARKER_END_RV
exit
cat > /tmp/r2.sh << 'REMOTE_EOF'
sed -n '1,15p' /opt/gush2/backend/apps/projects/views.py
REMOTE_EOF

bash /tmp/r2.sh; echo MARKER_END_R2
exit
cat > /tmp/r3.sh << 'REMOTE_EOF'
echo ---A.imports15_35---
sed -n '15,35p' /opt/gush2/backend/apps/projects/views.py
echo ---END---
REMOTE_EOF

bash /tmp/r3.sh; echo MARKER_END_R3
exit
cat > /tmp/patch_views.sh << 'REMOTE_EOF'
set -e

VIEWS=/opt/gush2/backend/apps/projects/views.py
BACKUP=/home/ubuntu/gush2-snapshots/views.py.bak.$(date +%Y%m%d-%H%M%S)
mkdir -p /home/ubuntu/gush2-snapshots
cp $VIEWS $BACKUP
echo "BACKUP=$BACKUP"

# --- Patch 1: class 改 ModelViewSet + 加 http_method_names ---
python3 << 'PYEOF'
import re
p = '/opt/gush2/backend/apps/projects/views.py'
s = open(p, encoding='utf-8').read()

old1 = '''class RedeemCodeViewSet(viewsets.ReadOnlyModelViewSet):
    """
    兑换码：
    - GET /api/projects/codes/                     列表（带分页）
    - GET /api/projects/codes/{id}/                详情
    - POST /api/projects/codes/{id}/revoke/      作废（仅未使用可作废）
    """
    permission_classes = (IsAuthenticated,)
    serializer_class = RedeemCodeSerializer
    pagination_class = RedeemCodePagination
    queryset = RedeemCode.objects.all()'''

new1 = '''class RedeemCodeViewSet(viewsets.ModelViewSet):
    """
    兑换码：
    - GET    /api/projects/codes/                  列表（带分页）
    - GET    /api/projects/codes/{id}/             详情
    - POST   /api/projects/codes/{id}/revoke/      作废（仅未使用可作废）
    - DELETE /api/projects/codes/{id}/             物理删除（全部状态可删，审计由中间件记 path）
    - create / update / partial_update：显式 405（不允许通过此 ViewSet 创建或修改）
    """
    permission_classes = (IsAuthenticated,)
    serializer_class = RedeemCodeSerializer
    pagination_class = RedeemCodePagination
    queryset = RedeemCode.objects.all()
    http_method_names = ["get", "post", "delete", "head", "options"]'''

assert old1 in s, 'PATCH1_OLD_NOT_FOUND'
s = s.replace(old1, new1)
open(p, 'w', encoding='utf-8').write(s)
print('PATCH1_OK')
PYEOF

# --- Patch 2: 在 revoke 函数之后追加 create/update/partial_update 405 + destroy ---
python3 << 'PYEOF'
p = '/opt/gush2/backend/apps/projects/views.py'
s = open(p, encoding='utf-8').read()

anchor = '''    @action(detail=True, methods=["post"])
    def revoke(self, request, pk=None):
        code = self.get_object()
        if code.status != RedeemCode.Status.UNUSED:
            return Response({"detail": "只能作废未使用的兑换码"}, status=400)
        code.status = RedeemCode.Status.REVOKED
        code.save(update_fields=["status"])
        return Response(RedeemCodeSerializer(code).data)'''

addition = '''

    def create(self, request, *args, **kwargs):
        return Response(
            {"detail": "请使用 /api/projects/codes/batch-generate/ 创建兑换码"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED,
        )

    def update(self, request, *args, **kwargs):
        return Response(
            {"detail": "兑换码不支持修改，请作废后重新生成"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED,
        )

    def partial_update(self, request, *args, **kwargs):
        return Response(
            {"detail": "兑换码不支持修改，请作废后重新生成"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED,
        )

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response(status=status.HTTP_204_NO_CONTENT)'''

assert anchor in s, 'ANCHOR_NOT_FOUND'
s = s.replace(anchor, anchor + addition)
open(p, 'w', encoding='utf-8').write(s)
print('PATCH2_OK')
PYEOF

echo ---verify---
grep -nE "class RedeemCodeViewSet|http_method_names|def destroy|def create|def update|def partial_update" $VIEWS
echo ---diff_lines---
diff -u $BACKUP $VIEWS | head -60
echo ---END---
REMOTE_EOF

bash /tmp/patch_views.sh; echo MARKER_END_PV
exit
cat > /tmp/r4.sh << 'REMOTE_EOF'
echo ---A.viewset_block---
grep -n "class RedeemCodeViewSet" /opt/gush2/backend/apps/projects/views.py
echo ---B.lines_280_305---
sed -n '280,305p' /opt/gush2/backend/apps/projects/views.py
echo ---C.literal_dump---
sed -n '283,290p' /opt/gush2/backend/apps/projects/views.py | cat -A | head -10
echo ---END---
REMOTE_EOF

bash /tmp/r4.sh; echo MARKER_END_R4
exit
cat > /tmp/patch_views2.sh << 'REMOTE_EOF'
set -e

VIEWS=/opt/gush2/backend/apps/projects/views.py
BACKUP=/home/ubuntu/gush2-snapshots/views.py.bak.$(date +%Y%m%d-%H%M%S)
mkdir -p /home/ubuntu/gush2-snapshots
cp $VIEWS $BACKUP
echo "BACKUP=$BACKUP"

python3 << 'PYEOF'
p = '/opt/gush2/backend/apps/projects/views.py'
s = open(p, encoding='utf-8').read()

old1 = '''class RedeemCodeViewSet(viewsets.ReadOnlyModelViewSet):
    """
    GET    /api/projects/codes/?project={id}&status=unused
    POST   /api/projects/codes/{id}/revoke/
    """
    permission_classes = (IsAuthenticated,)
    serializer_class = RedeemCodeSerializer
    pagination_class = RedeemCodePagination
    queryset = RedeemCode.objects.all()'''

new1 = '''class RedeemCodeViewSet(viewsets.ModelViewSet):
    """
    GET    /api/projects/codes/?project={id}&status=unused
    POST   /api/projects/codes/{id}/revoke/
    DELETE /api/projects/codes/{id}/             物理删除（全部状态可删，审计由中间件记 path）
    create / update / partial_update：显式 405（不允许通过此 ViewSet 创建或修改）
    """
    permission_classes = (IsAuthenticated,)
    serializer_class = RedeemCodeSerializer
    pagination_class = RedeemCodePagination
    queryset = RedeemCode.objects.all()
    http_method_names = ["get", "post", "delete", "head", "options"]'''

assert old1 in s, 'PATCH1_OLD_NOT_FOUND'
s = s.replace(old1, new1)

anchor = '''    @action(detail=True, methods=["post"])
    def revoke(self, request, pk=None):
        code = self.get_object()
        if code.status != RedeemCode.Status.UNUSED:
            return Response({"detail": "只能作废未使用的兑换码"}, status=400)
        code.status = RedeemCode.Status.REVOKED
        code.save(update_fields=["status"])
        return Response(RedeemCodeSerializer(code).data)'''

addition = '''

    def create(self, request, *args, **kwargs):
        return Response(
            {"detail": "请使用 /api/projects/codes/batch-generate/ 创建兑换码"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED,
        )

    def update(self, request, *args, **kwargs):
        return Response(
            {"detail": "兑换码不支持修改，请作废后重新生成"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED,
        )

    def partial_update(self, request, *args, **kwargs):
        return Response(
            {"detail": "兑换码不支持修改，请作废后重新生成"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED,
        )

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response(status=status.HTTP_204_NO_CONTENT)'''

assert anchor in s, 'PATCH2_ANCHOR_NOT_FOUND'
s = s.replace(anchor, anchor + addition)

open(p, 'w', encoding='utf-8').write(s)
print('PATCH_OK')
PYEOF

echo ---verify---
grep -nE "class RedeemCodeViewSet|http_method_names|def destroy|def create|def update|def partial_update" $VIEWS
echo ---END---
REMOTE_EOF

bash /tmp/patch_views2.sh; echo MARKER_END_PV2
exit
cat > /tmp/r5.sh << 'REMOTE_EOF'
echo ---A.line_79_context---
sed -n '75,95p' /opt/gush2/backend/apps/projects/views.py
echo ---B.django_check---
cd /opt/gush2/backend && sudo docker exec gush2-backend python -c "
import django, os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'gush.settings')
import sys
sys.path.insert(0, '/app')
django.setup()
from apps.projects.views import RedeemCodeViewSet
print('OK', RedeemCodeViewSet, sorted(set(RedeemCodeViewSet.http_method_names)))
" 2>&1 | tail -20
echo ---END---
REMOTE_EOF

bash /tmp/r5.sh; echo MARKER_END_R5
exit
cat > /tmp/deploybe.sh << 'REMOTE_EOF'
echo ---A.current_backend---
sudo docker ps --format 'table {{.Names}}{{.Status}}{{.Image}}' | grep -E "backend"
echo ---B.build---
cd /opt/gush2 && sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build backend 2>&1 | tail -20
echo ---C.up---
sudo docker compose -f /opt/gush2/docker-compose.prod.yml --env-file /opt/gush2/.env.prod up -d backend 2>&1 | tail -10
echo ---D.ps---
sleep 5; sudo docker ps --format 'table {{.Names}}{{.Status}}{{.Ports}}' | grep -E "backend|nginx"
echo ---E.backend_log---
sudo docker logs --tail 40 gush2-backend 2>&1 | tail -25
echo ---END---
REMOTE_EOF

bash /tmp/deploybe.sh; echo MARKER_END_DEPLOYBE
exit
cat > /tmp/gettok.sh << 'REMOTE_EOF'
echo ---A.get_token---
TOKEN=$(curl -sk -X POST https://admin.gush.cdgushai.com/api/auth/login/ -H "Content-Type: application/json" -d '{"username":"admin","password":"admin"}' 2>&1)
echo "RESP1=$TOKEN" | head -c 300
echo
echo ---try_known_pw---
for pw in "admin" "Admin@123" "admin123" "gush2-admin" "admin@2024" "yaoyao1986630!"; do
  R=$(curl -sk -X POST https://admin.gush.cdgushai.com/api/auth/login/ -H "Content-Type: application/json" -d "{\"username\":\"admin\",\"password\":\"$pw\"}" 2>&1)
  echo "pw=$pw -> $R" | head -c 200
  echo
done
echo ---END---
REMOTE_EOF

bash /tmp/gettok.sh; echo MARKER_END_TOK
exit
cat > /tmp/getpw.sh << 'REMOTE_EOF'
echo ---A.superuser_pw---
grep -E "DJANGO_SUPERUSER" /opt/gush2/.env /opt/gush2/.env.prod 2>&1
echo ---END---
REMOTE_EOF

bash /tmp/getpw.sh; echo MARKER_END_PW
exit
cat > /tmp/verifyapi.sh << 'REMOTE_EOF'
echo ---A.login---
LOGIN=$(curl -sk -X POST https://admin.gush.cdgushai.com/api/auth/login/ -H 'Content-Type: application/json' -d '{"username":"admin","password":"gaoxiao200606"}')
echo "LOGIN=${LOGIN:0:200}"
TOKEN=$(echo "$LOGIN" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('access') or d.get('token') or d.get('access_token') or list(d.values())[0] if d else '')" 2>&1)
echo "TOKEN_LEN=${#TOKEN}"
echo "TOKEN_HEAD=${TOKEN:0:30}..."

echo ---B.list_codes---
curl -sk -H "Authorization: Bearer $TOKEN" 'https://admin.gush.cdgushai.com/api/projects/codes/?project=2&page_size=5' | python3 -c "
import json,sys
d=json.load(sys.stdin)
r=d.get('results',d) if isinstance(d,dict) else d
print('TOTAL', d.get('count','?') if isinstance(d,dict) else len(r))
if r:
    print('FIRST', r[0].get('id'), r[0].get('code'), r[0].get('status'))
    for x in r[:3]:
        print(' -', x['id'], x['code'], x['status'])
"

echo ---C.pick_unused_id---
ID=$(curl -sk -H "Authorization: Bearer $TOKEN" 'https://admin.gush.cdgushai.com/api/projects/codes/?project=2&status=unused&page_size=1' | python3 -c "
import json,sys
d=json.load(sys.stdin)
r=d.get('results',d) if isinstance(d,dict) else d
print(r[0]['id'] if r else 'NONE')
")
echo "ID=$ID"

echo ---D.405_for_create---
curl -sk -X POST -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/json' -d '{}' -o /dev/null -w 'POST_create=%{http_code}\n' "https://admin.gush.cdgushai.com/api/projects/codes/"
echo ---E.405_for_update---
curl -sk -X PATCH -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/json' -d '{}' -o /dev/null -w 'PATCH_update=%{http_code}\n' "https://admin.gush.cdgushai.com/api/projects/codes/1/"

echo ---F.delete_test---
if [ "$ID" != "NONE" ]; then
  curl -sk -X DELETE -H "Authorization: Bearer $TOKEN" -o /dev/null -w 'DELETE=%{http_code}\n' "https://admin.gush.cdgushai.com/api/projects/codes/$ID/"
  curl -sk -H "Authorization: Bearer $TOKEN" -o /dev/null -w 'GET_after=%{http_code}\n' "https://admin.gush.cdgushai.com/api/projects/codes/$ID/"
else
  echo "no unused code to delete"
fi
echo ---END---
REMOTE_EOF

bash /tmp/verifyapi.sh; echo MARKER_END_VA
exit
cat > /tmp/deployfe.sh << 'REMOTE_EOF'
set -e
cd /opt/gush2
TS=$(date +%Y%m%d-%H%M%S)
SNAP_DIR=/home/ubuntu/gush2-snapshots/$TS
mkdir -p $SNAP_DIR

echo ---A.snapshot---
tar czf $SNAP_DIR/frontend-src.tar.gz frontend/src
cp frontend/src/api/projects.js $SNAP_DIR/projects.js.online
cp frontend/src/views/projects/ProjectDetail.vue $SNAP_DIR/ProjectDetail.vue.online
echo "SNAP_DIR=$SNAP_DIR"

echo ---B.replace_projects_js---
base64 -d /tmp/projects.js.b64 > frontend/src/api/projects.js
echo "projects.js md5=$(md5sum frontend/src/api/projects.js | cut -d' ' -f1)"

echo ---C.replace_ProjectDetail_vue---
base64 -d /tmp/ProjectDetail.vue.b64 > frontend/src/views/projects/ProjectDetail.vue
echo "ProjectDetail.vue md5=$(md5sum frontend/src/views/projects/ProjectDetail.vue | cut -d' ' -f1)"

echo ---D.build---
sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build nginx 2>&1 | tail -15

echo ---E.up---
sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d nginx 2>&1 | tail -8

echo ---F.ps---
sleep 6
sudo docker ps --format 'table {{.Names}}{{.Status}}{{.Ports}}' | grep -E "nginx|backend"
echo "DONE $TS"
echo ---END---
REMOTE_EOF

bash /tmp/deployfe.sh; echo MARKER_END_DFE
exit
cat > /tmp/projects.js.b64 << 'B64EOF'
LyoqCiAqIOmhueebriAvIOWFkeaNoueggSBBUEkKICovCmltcG9ydCBodHRwIGZyb20gJy4vaHR0cCcKCi8vIC0tLS0g6aG555uuIC0tLS0KZXhwb3J0IGZ1bmN0aW9uIGxpc3RQcm9qZWN0cyhwYXJhbXMgPSB7fSkgewogIHJldHVybiBodHRwLmdldCgnL3Byb2plY3RzL3Byb2plY3RzLycsIHsgcGFyYW1zIH0pCn0KZXhwb3J0IGZ1bmN0aW9uIGdldFByb2plY3QoaWQpIHsKICByZXR1cm4gaHR0cC5nZXQoYC9wcm9qZWN0cy9wcm9qZWN0cy8ke2lkfS9gKQp9CmV4cG9ydCBmdW5jdGlvbiBjcmVhdGVQcm9qZWN0KGRhdGEpIHsKICByZXR1cm4gaHR0cC5wb3N0KCcvcHJvamVjdHMvcHJvamVjdHMvJywgZGF0YSkKfQpleHBvcnQgZnVuY3Rpb24gdXBkYXRlUHJvamVjdChpZCwgZGF0YSkgewogIHJldHVybiBodHRwLnBhdGNoKGAvcHJvamVjdHMvcHJvamVjdHMvJHtpZH0vYCwgZGF0YSkKfQpleHBvcnQgZnVuY3Rpb24gZGVsZXRlUHJvamVjdChpZCkgewogIHJldHVybiBodHRwLmRlbGV0ZShgL3Byb2plY3RzL3Byb2plY3RzLyR7aWR9L2ApCn0KZXhwb3J0IGZ1bmN0aW9uIGJpbmRNYWNoaW5lcyhpZCwgbWFjaGluZUlkcykgewogIHJldHVybiBodHRwLnBvc3QoYC9wcm9qZWN0cy9wcm9qZWN0cy8ke2lkfS9iaW5kX21hY2hpbmVzL2AsIHsgbWFjaGluZV9pZHM6IG1hY2hpbmVJZHMgfSkKfQpleHBvcnQgZnVuY3Rpb24gYmluZFByb2R1Y3RzKGlkLCBwcm9kdWN0SWRzKSB7CiAgcmV0dXJuIGh0dHAucG9zdChgL3Byb2plY3RzL3Byb2plY3RzLyR7aWR9L2JpbmRfcHJvZHVjdHMvYCwgeyBwcm9kdWN0X2lkczogcHJvZHVjdElkcyB9KQp9CmV4cG9ydCBmdW5jdGlvbiBnZW5lcmF0ZUNvZGVzKGlkLCBjb3VudCkgewogIHJldHVybiBodHRwLnBvc3QoYC9wcm9qZWN0cy9wcm9qZWN0cy8ke2lkfS9nZW5lcmF0ZV9jb2Rlcy9gLCB7IGNvdW50IH0pCn0KZXhwb3J0IGZ1bmN0aW9uIHByZWZsaWdodFByb2plY3QoaWQpIHsKICByZXR1cm4gaHR0cC5nZXQoYC9wcm9qZWN0cy9wcm9qZWN0cy8ke2lkfS9wcmVmbGlnaHQvYCkKfQpleHBvcnQgZnVuY3Rpb24gdHJhbnNpdGlvblByb2plY3QoaWQsIHRvLCBmb3JjZSA9IGZhbHNlKSB7CiAgcmV0dXJuIGh0dHAucG9zdChgL3Byb2plY3RzL3Byb2plY3RzLyR7aWR9L3RyYW5zaXRpb24vYCwgeyB0bywgZm9yY2UgfSkKfQoKLy8gLS0tLSDlhZHmjaLnoIEgLS0tLQpleHBvcnQgZnVuY3Rpb24gbGlzdFJlZGVlbUNvZGVzKHBhcmFtcyA9IHt9KSB7CiAgcmV0dXJuIGh0dHAuZ2V0KCcvcHJvamVjdHMvY29kZXMvJywgeyBwYXJhbXMgfSkKfQpleHBvcnQgZnVuY3Rpb24gcmV2b2tlQ29kZShpZCkgewogIHJldHVybiBodHRwLnBvc3QoYC9wcm9qZWN0cy9jb2Rlcy8ke2lkfS9yZXZva2UvYCwge30pCn0KZXhwb3J0IGZ1bmN0aW9uIGRlbGV0ZVJlZGVlbUNvZGUoaWQpIHsKICByZXR1cm4gaHR0cC5kZWxldGUoYC9wcm9qZWN0cy9jb2Rlcy8ke2lkfS9gKQp9Cg==
B64EOF

cat > /tmp/ProjectDetail.vue.b64 << 'B64EOF'
PHRlbXBsYXRlPgogIDxkaXYgdi1sb2FkaW5nPSJsb2FkaW5nIiBjbGFzcz0icHJvamVjdC1kZXRhaWwiPgogICAgPCEtLSDpobbpg6jkv6Hmga8gLS0+CiAgICA8ZWwtY2FyZCB2LWlmPSJwcm9qZWN0IiBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iaW5mby1jYXJkIj4KICAgICAgPHRlbXBsYXRlICNoZWFkZXI+CiAgICAgICAgPGRpdiBjbGFzcz0iaGVhZGVyLXJvdyI+CiAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJBcnJvd0xlZnQiIGxpbmsgQGNsaWNrPSIkcm91dGVyLnB1c2goJy9wcm9qZWN0cycpIj7ov5Tlm57liJfooag8L2VsLWJ1dHRvbj4KICAgICAgICAgIDxzcGFuIGNsYXNzPSJ0aXRsZSI+e3sgcHJvamVjdC5uYW1lIH19PC9zcGFuPgogICAgICAgICAgPGVsLXRhZyA6dHlwZT0ic3RhdHVzVGFnKHByb2plY3Quc3RhdHVzKSIgc2l6ZT0ic21hbGwiPnt7IHN0YXR1c0xhYmVsKHByb2plY3Quc3RhdHVzKSB9fTwvZWwtdGFnPgogICAgICAgICAgPGRpdiBjbGFzcz0ic3BhY2VyIiAvPgogICAgICAgICAgPCEtLSDnirbmgIHovaznp7vmjInpkq7vvJrpmo8gcHJvamVjdC5zdGF0dXMg5Y+Y5YyWIC0tPgogICAgICAgICAgPHRlbXBsYXRlIHYtaWY9InByb2plY3Quc3RhdHVzID09PSAnZHJhZnQnIj4KICAgICAgICAgICAgPGVsLWJ1dHRvbiB0eXBlPSJzdWNjZXNzIiA6aWNvbj0iVmlkZW9QbGF5IiA6bG9hZGluZz0idHJhbnNpdGlvbmluZyIgQGNsaWNrPSJvblB1Ymxpc2giPgogICAgICAgICAgICAgIOWPkeW4g+S4iue6vwogICAgICAgICAgICA8L2VsLWJ1dHRvbj4KICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICA8dGVtcGxhdGUgdi1lbHNlLWlmPSJwcm9qZWN0LnN0YXR1cyA9PT0gJ3J1bm5pbmcnIj4KICAgICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iVmlkZW9QYXVzZSIgOmxvYWRpbmc9InRyYW5zaXRpb25pbmciIEBjbGljaz0ib25UcmFuc2l0aW9uKCdwYXVzZWQnKSI+CiAgICAgICAgICAgICAg5pqC5YGcCiAgICAgICAgICAgIDwvZWwtYnV0dG9uPgogICAgICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9ImRhbmdlciIgcGxhaW4gOmljb249IkNpcmNsZUNsb3NlIiA6bG9hZGluZz0idHJhbnNpdGlvbmluZyIgQGNsaWNrPSJvblRyYW5zaXRpb24oJ2ZpbmlzaGVkJykiPgogICAgICAgICAgICAgIOe7k+adn+a0u+WKqAogICAgICAgICAgICA8L2VsLWJ1dHRvbj4KICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgICA8dGVtcGxhdGUgdi1lbHNlLWlmPSJwcm9qZWN0LnN0YXR1cyA9PT0gJ3BhdXNlZCciPgogICAgICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9InN1Y2Nlc3MiIDppY29uPSJWaWRlb1BsYXkiIDpsb2FkaW5nPSJ0cmFuc2l0aW9uaW5nIiBAY2xpY2s9Im9uVHJhbnNpdGlvbigncnVubmluZycpIj4KICAgICAgICAgICAgICDnu6fnu60KICAgICAgICAgICAgPC9lbC1idXR0b24+CiAgICAgICAgICAgIDxlbC1idXR0b24gdHlwZT0iZGFuZ2VyIiBwbGFpbiA6aWNvbj0iQ2lyY2xlQ2xvc2UiIDpsb2FkaW5nPSJ0cmFuc2l0aW9uaW5nIiBAY2xpY2s9Im9uVHJhbnNpdGlvbignZmluaXNoZWQnKSI+CiAgICAgICAgICAgICAg57uT5p2f5rS75YqoCiAgICAgICAgICAgIDwvZWwtYnV0dG9uPgogICAgICAgICAgPC90ZW1wbGF0ZT4KCiAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJNYWdpY1N0aWNrIiB0eXBlPSJwcmltYXJ5IiBAY2xpY2s9IiRyb3V0ZXIucHVzaChgL3Byb2plY3RzLyR7JHJvdXRlLnBhcmFtcy5pZH0vcGFnZS1lZGl0b3JgKSI+CiAgICAgICAgICAgIOmhtemdouijheS/rgogICAgICAgICAgPC9lbC1idXR0b24+CiAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJVc2VyIiBAY2xpY2s9IiRyb3V0ZXIucHVzaChgL3Byb2plY3RzLyR7JHJvdXRlLnBhcmFtcy5pZH0vbGVhZHNgKSI+CiAgICAgICAgICAgIOeUqOaIt+iOt+WuogogICAgICAgICAgPC9lbC1idXR0b24+CiAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJMaW5rIiBAY2xpY2s9Im9wZW5INSI+5omT5byAIEg1IOmhtemdojwvZWwtYnV0dG9uPgogICAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iUmVmcmVzaCIgQGNsaWNrPSJyZWxvYWQiPuWIt+aWsDwvZWwtYnV0dG9uPgogICAgICAgIDwvZGl2PgogICAgICA8L3RlbXBsYXRlPgoKICAgICAgPGVsLWRlc2NyaXB0aW9ucyA6Y29sdW1uPSIzIiBib3JkZXIgc2l6ZT0ic21hbGwiPgogICAgICAgIDxlbC1kZXNjcmlwdGlvbnMtaXRlbSBsYWJlbD0i5pe26Ze0IiA6c3Bhbj0iMiI+CiAgICAgICAgICB7eyBmb3JtYXRUaW1lKHByb2plY3Quc3RhcnRzX2F0KSB9fSB+IHt7IGZvcm1hdFRpbWUocHJvamVjdC5lbmRzX2F0KSB9fQogICAgICAgIDwvZWwtZGVzY3JpcHRpb25zLWl0ZW0+CiAgICAgICAgPGVsLWRlc2NyaXB0aW9ucy1pdGVtIGxhYmVsPSLnoIHplb/luqYgLyDmnInmlYjmnJ8iPgogICAgICAgICAge3sgcHJvamVjdC5jb2RlX2xlbmd0aCB9fSDkvY0gLyB7eyBwcm9qZWN0LmNvZGVfdmFsaWRpdHlfZGF5cyB9fSDlpKkKICAgICAgICA8L2VsLWRlc2NyaXB0aW9ucy1pdGVtPgogICAgICAgIDxlbC1kZXNjcmlwdGlvbnMtaXRlbSBsYWJlbD0i5rS75Yqo5o+P6L+wIiA6c3Bhbj0iMyI+e3sgcHJvamVjdC5kZXNjcmlwdGlvbiB8fCAn4oCUJyB9fTwvZWwtZGVzY3JpcHRpb25zLWl0ZW0+CiAgICAgICAgPGVsLWRlc2NyaXB0aW9ucy1pdGVtIGxhYmVsPSLmtLvliqjop4TliJkiIDpzcGFuPSIzIj4KICAgICAgICAgIDxwcmUgY2xhc3M9InJ1bGVzIj57eyBwcm9qZWN0LnJ1bGVzX3RleHQgfHwgJ+KAlCcgfX08L3ByZT4KICAgICAgICA8L2VsLWRlc2NyaXB0aW9ucy1pdGVtPgogICAgICA8L2VsLWRlc2NyaXB0aW9ucz4KICAgIDwvZWwtY2FyZD4KCiAgICA8IS0tIOWuouaIt+err+eci+adv+mTvuaOpSAtLT4KICAgIDxlbC1jYXJkIHYtaWY9InByb2plY3QiIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJpbmZvLWNhcmQiPgogICAgICA8dGVtcGxhdGUgI2hlYWRlcj4KICAgICAgICA8ZGl2IGNsYXNzPSJoZWFkZXItcm93Ij4KICAgICAgICAgIDxzcGFuIGNsYXNzPSJ0aXRsZSI+5a6i5oi356uv55yL5p2/PC9zcGFuPgogICAgICAgICAgPHNwYW4gY2xhc3M9ImhpbnQiIHN0eWxlPSJjb2xvcjojOTA5Mzk5O2ZvbnQtc2l6ZToxMnB4Ij7lsIbmraTpk77mjqXlj5Hnu5nlrqLmiLfnlLLmlrnvvIzmiYvmnLrkuIrljbPlj6/mn6XnnIvpobnnm67mlbDmja48L3NwYW4+CiAgICAgICAgICA8ZGl2IGNsYXNzPSJzcGFjZXIiIC8+CiAgICAgICAgPC9kaXY+CiAgICAgIDwvdGVtcGxhdGU+CiAgICAgIDxkaXYgY2xhc3M9ImNsaWVudC11cmwtcm93IiB2LWlmPSJwcm9qZWN0LmNsaWVudF91cmwiPgogICAgICAgIDxjb2RlIGNsYXNzPSJ1cmwtdGV4dCI+e3sgcHJvamVjdC5jbGllbnRfdXJsIH19PC9jb2RlPgogICAgICAgIDxlbC1idXR0b24gdHlwZT0icHJpbWFyeSIgc2l6ZT0ic21hbGwiIHBsYWluIEBjbGljaz0iY29weUNsaWVudFVybCI+5aSN5Yi26ZO+5o6lPC9lbC1idXR0b24+CiAgICAgICAgPGVsLWJ1dHRvbiBzaXplPSJzbWFsbCIgcGxhaW4gQGNsaWNrPSJvcGVuQ2xpZW50VXJsIiA6aWNvbj0iTGluayI+5omT5byAPC9lbC1idXR0b24+CiAgICAgIDwvZGl2PgogICAgICA8ZGl2IHYtZWxzZSBjbGFzcz0idW5zZXQtcm93Ij7lrqLmiLfnq68gdG9rZW4g5bCa5pyq55Sf5oiQPC9kaXY+CiAgICA8L2VsLWNhcmQ+CgogICAgPCEtLSDorr7lpIfnu5HlrpogLS0+CiAgICA8ZWwtY2FyZCB2LWlmPSJwcm9qZWN0IiBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iaW5mby1jYXJkIj4KICAgICAgPHRlbXBsYXRlICNoZWFkZXI+CiAgICAgICAgPGRpdiBjbGFzcz0iaGVhZGVyLXJvdyI+CiAgICAgICAgICA8c3BhbiBjbGFzcz0idGl0bGUiPue7keWumuiuvuWkh++8iHt7IHByb2plY3QubWFjaGluZXMubGVuZ3RoIH19IOWPsO+8iTwvc3Bhbj4KICAgICAgICAgIDxkaXYgY2xhc3M9InNwYWNlciIgLz4KICAgICAgICAgIDxlbC1idXR0b24gOmljb249IkVkaXQiIEBjbGljaz0ib3BlbkJpbmREaWFsb2ciPuS/ruaUuee7keWumjwvZWwtYnV0dG9uPgogICAgICAgIDwvZGl2PgogICAgICA8L3RlbXBsYXRlPgogICAgICA8ZWwtdGFibGUgOmRhdGE9InByb2plY3QubWFjaGluZXMiIHN0cmlwZSBzaXplPSJzbWFsbCI+CiAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBwcm9wPSJtYWNoaW5lX2lkIiBsYWJlbD0i6K6+5aSH57yW5Y+3IiB3aWR0aD0iMTMwIiAvPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gcHJvcD0ibmFtZSIgbGFiZWw9IuWQjeensCIgd2lkdGg9IjEyMCIgLz4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIGxhYmVsPSLnirbmgIEiIHdpZHRoPSI5MCI+CiAgICAgICAgICA8dGVtcGxhdGUgI2RlZmF1bHQ9Insgcm93IH0iPgogICAgICAgICAgICA8ZWwtdGFnIDp0eXBlPSJtYWNoaW5lU3RhdHVzVGFnKHJvdy5zdGF0dXMpIiBzaXplPSJzbWFsbCI+e3sgbWFjaGluZVN0YXR1c0xhYmVsKHJvdy5zdGF0dXMpIH19PC9lbC10YWc+CiAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgIDwvZWwtdGFibGUtY29sdW1uPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gbGFiZWw9Ikg1IOiQveWcsOmhtSBVUkwiIG1pbi13aWR0aD0iMzIwIj4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD0ieyByb3cgfSI+CiAgICAgICAgICAgIDxBY2Nlc3NVcmxDYXJkCiAgICAgICAgICAgICAgbGFiZWw9Ikg1IgogICAgICAgICAgICAgIDp1cmw9InN5cy5oNVVybChwcm9qZWN0LmlkLCByb3cubWFjaGluZV9pZCkiCiAgICAgICAgICAgICAgOm1hY2hpbmUtaWQ9InJvdy5pZCIgLz4KICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC10YWJsZS1jb2x1bW4+CiAgICAgIDwvZWwtdGFibGU+CiAgICA8L2VsLWNhcmQ+CgogICAgPCEtLSDnpLzlk4HmjILovb0gLS0+CiAgICA8ZWwtY2FyZCB2LWlmPSJwcm9qZWN0IiBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iaW5mby1jYXJkIj4KICAgICAgPHRlbXBsYXRlICNoZWFkZXI+CiAgICAgICAgPGRpdiBjbGFzcz0iaGVhZGVyLXJvdyI+CiAgICAgICAgICA8c3BhbiBjbGFzcz0idGl0bGUiPuacrOa0u+WKqOekvOWTge+8iHt7IHByb2plY3QucHJvZHVjdHM/Lmxlbmd0aCB8fCAwIH19IOS4qu+8iTwvc3Bhbj4KICAgICAgICAgIDxkaXYgY2xhc3M9InNwYWNlciIgLz4KICAgICAgICAgIDxlbC1idXR0b24gOmljb249IkVkaXQiIEBjbGljaz0ib3BlblByb2R1Y3REaWFsb2ciPumAieaLqeekvOWTgTwvZWwtYnV0dG9uPgogICAgICAgIDwvZGl2PgogICAgICA8L3RlbXBsYXRlPgogICAgICA8ZWwtZW1wdHkgdi1pZj0iIXByb2plY3QucHJvZHVjdHM/Lmxlbmd0aCIgZGVzY3JpcHRpb249IuWwmuacquaMgui9veekvOWTge+8iOWFkeaNouaXtuWwhuWFgeiuuOS7u+aEj+i0p+mBk+WHuui0p++8iSIgOmltYWdlLXNpemU9IjYwIiAvPgogICAgICA8ZWwtdGFibGUgdi1lbHNlIDpkYXRhPSJwcm9qZWN0LnByb2R1Y3RzIiBzdHJpcGUgc2l6ZT0ic21hbGwiPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gbGFiZWw9IuWwgemdoiIgd2lkdGg9IjY0Ij4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD0ieyByb3cgfSI+CiAgICAgICAgICAgIDxlbC1pbWFnZSB2LWlmPSJyb3cuaW1hZ2VfdXJsIiA6c3JjPSJyb3cuaW1hZ2VfdXJsIiBmaXQ9ImNvdmVyIiBzdHlsZT0id2lkdGg6NDBweDtoZWlnaHQ6NDBweDtib3JkZXItcmFkaXVzOjRweCIgLz4KICAgICAgICAgICAgPHNwYW4gdi1lbHNlIHN0eWxlPSJjb2xvcjojNjY2Ij7igJQ8L3NwYW4+CiAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgIDwvZWwtdGFibGUtY29sdW1uPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gcHJvcD0ic2t1IiBsYWJlbD0iU0tVIiB3aWR0aD0iMTIwIiAvPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gcHJvcD0ibmFtZSIgbGFiZWw9IuWQjeensCIgLz4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIHByb3A9ImJyYW5kIiBsYWJlbD0i5ZOB54mMIiB3aWR0aD0iMTIwIiAvPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gcHJvcD0idG90YWxfc3RvY2siIGxhYmVsPSLku5PlupPlupPlrZgiIHdpZHRoPSIxMDAiIGFsaWduPSJyaWdodCIgLz4KICAgICAgPC9lbC10YWJsZT4KICAgIDwvZWwtY2FyZD4KCiAgICA8IS0tIOWFkeaNoueggSAtLT4KICAgIDxlbC1jYXJkIHYtaWY9InByb2plY3QiIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJpbmZvLWNhcmQiPgogICAgICA8dGVtcGxhdGUgI2hlYWRlcj4KICAgICAgICA8ZGl2IGNsYXNzPSJoZWFkZXItcm93Ij4KICAgICAgICAgIDxzcGFuIGNsYXNzPSJ0aXRsZSI+5YWR5o2i56CB77yI5YWxIHt7IGNvZGVUb3RhbCB9fSDkuKogwrcg5bey55SoIHt7IGNvZGVVc2VkIH1977yJPC9zcGFuPgogICAgICAgICAgPGVsLXNlbGVjdCB2LW1vZGVsPSJjb2RlRmlsdGVyIiBwbGFjZWhvbGRlcj0i54q25oCBIiBzdHlsZT0id2lkdGg6MTIwcHg7bWFyZ2luLWxlZnQ6MTJweCIgQGNoYW5nZT0ibG9hZENvZGVzIj4KICAgICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5YWo6YOoIiB2YWx1ZT0iIiAvPgogICAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLmnKrkvb/nlKgiIHZhbHVlPSJ1bnVzZWQiIC8+CiAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuW3suS9v+eUqCIgdmFsdWU9InVzZWQiIC8+CiAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuW3sui/h+acnyIgdmFsdWU9ImV4cGlyZWQiIC8+CiAgICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuW3suS9nOW6nyIgdmFsdWU9InJldm9rZWQiIC8+CiAgICAgICAgICA8L2VsLXNlbGVjdD4KICAgICAgICAgIDxkaXYgY2xhc3M9InNwYWNlciIgLz4KICAgICAgICAgIDxlbC1idXR0b24gOmljb249IlBsdXMiIHR5cGU9InByaW1hcnkiIEBjbGljaz0ib3BlbkdlbkRpYWxvZyI+5om56YeP55Sf5oiQPC9lbC1idXR0b24+CiAgICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJEZWxldGUiIHR5cGU9ImRhbmdlciIgOmRpc2FibGVkPSIhc2VsZWN0ZWRDb2RlSWRzLmxlbmd0aCIgQGNsaWNrPSJiYXRjaERlbGV0ZUNvZGVzIiBzdHlsZT0ibWFyZ2luLWxlZnQ6OHB4Ij4KICAgICAgICAgICAg5om56YeP5Yig6ZmkPHNwYW4gdi1pZj0ic2VsZWN0ZWRDb2RlSWRzLmxlbmd0aCI+77yIe3sgc2VsZWN0ZWRDb2RlSWRzLmxlbmd0aCB9fe+8iTwvc3Bhbj4KICAgICAgICAgIDwvZWwtYnV0dG9uPgogICAgICAgIDwvZGl2PgogICAgICA8L3RlbXBsYXRlPgoKICAgICAgPGVsLXRhYmxlIHYtbG9hZGluZz0iY29kZUxvYWRpbmciIDpkYXRhPSJjb2RlcyIgc2l6ZT0ic21hbGwiIEBzZWxlY3Rpb24tY2hhbmdlPSJvbkNvZGVTZWxlY3Rpb25DaGFuZ2UiPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gdHlwZT0ic2VsZWN0aW9uIiB3aWR0aD0iNDgiIC8+CiAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBwcm9wPSJjb2RlIiBsYWJlbD0i5YWR5o2i56CBIiB3aWR0aD0iMTYwIj4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD0ieyByb3cgfSI+PGNvZGUgY2xhc3M9ImNvZGUtY2VsbCI+e3sgcm93LmNvZGUgfX08L2NvZGU+PC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLXRhYmxlLWNvbHVtbj4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIGxhYmVsPSLnirbmgIEiIHdpZHRoPSIxMDAiPgogICAgICAgICAgPHRlbXBsYXRlICNkZWZhdWx0PSJ7IHJvdyB9Ij4KICAgICAgICAgICAgPGVsLXRhZyA6dHlwZT0iY29kZVN0YXR1c1RhZyhyb3cuc3RhdHVzKSIgc2l6ZT0ic21hbGwiPnt7IHJvdy5zdGF0dXNfbGFiZWwgfX08L2VsLXRhZz4KICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC10YWJsZS1jb2x1bW4+CiAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBsYWJlbD0i6L+H5pyf5pe26Ze0IiB3aWR0aD0iMTgwIj4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD0ieyByb3cgfSI+e3sgZm9ybWF0VGltZShyb3cuZXhwaXJlc19hdCkgfX08L3RlbXBsYXRlPgogICAgICAgIDwvZWwtdGFibGUtY29sdW1uPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gbGFiZWw9IuS9v+eUqOaXtumXtCIgd2lkdGg9IjE4MCI+CiAgICAgICAgICA8dGVtcGxhdGUgI2RlZmF1bHQ9Insgcm93IH0iPnt7IHJvdy51c2VkX2F0ID8gZm9ybWF0VGltZShyb3cudXNlZF9hdCkgOiAn4oCUJyB9fTwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC10YWJsZS1jb2x1bW4+CiAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBsYWJlbD0i5L2/55So6K6+5aSHIC8g6LSn6YGTIiBtaW4td2lkdGg9IjE2MCI+CiAgICAgICAgICA8dGVtcGxhdGUgI2RlZmF1bHQ9Insgcm93IH0iPgogICAgICAgICAgICB7eyByb3cudXNlZF9tYWNoaW5lX2lkIHx8ICfigJQnIH19PHNwYW4gdi1pZj0icm93LnVzZWRfb25fY2hhbm5lbF9jb2RlIj4gwrcge3sgcm93LnVzZWRfb25fY2hhbm5lbF9jb2RlIH19PC9zcGFuPgogICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLXRhYmxlLWNvbHVtbj4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIGxhYmVsPSLmk43kvZwiIHdpZHRoPSIxODAiIGZpeGVkPSJyaWdodCI+CiAgICAgICAgICA8dGVtcGxhdGUgI2RlZmF1bHQ9Insgcm93IH0iPgogICAgICAgICAgICA8ZWwtYnV0dG9uIHYtaWY9InJvdy5zdGF0dXMgPT09ICd1bnVzZWQnIiBsaW5rIHR5cGU9Indhcm5pbmciIEBjbGljaz0iZG9SZXZva2Uocm93KSI+5L2c5bqfPC9lbC1idXR0b24+CiAgICAgICAgICAgIDxlbC1idXR0b24gbGluayB0eXBlPSJkYW5nZXIiIEBjbGljaz0iZG9EZWxldGVDb2RlKHJvdykiPuWIoOmZpDwvZWwtYnV0dG9uPgogICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLXRhYmxlLWNvbHVtbj4KICAgICAgPC9lbC10YWJsZT4KICAgICAgPGVsLXBhZ2luYXRpb24KICAgICAgICB2LWlmPSJjb2RlUGFnZS50b3RhbCA+IGNvZGVQYWdlLnBhZ2VTaXplIgogICAgICAgIHYtbW9kZWw6Y3VycmVudC1wYWdlPSJjb2RlUGFnZS5jdXJyZW50IgogICAgICAgIDpwYWdlLXNpemU9ImNvZGVQYWdlLnBhZ2VTaXplIgogICAgICAgIDp0b3RhbD0iY29kZVBhZ2UudG90YWwiCiAgICAgICAgbGF5b3V0PSJwcmV2LCBwYWdlciwgbmV4dCwgdG90YWwiCiAgICAgICAgc3R5bGU9Im1hcmdpbi10b3A6MTJweDtqdXN0aWZ5LWNvbnRlbnQ6ZmxleC1lbmQ7ZGlzcGxheTpmbGV4IgogICAgICAgIEBjdXJyZW50LWNoYW5nZT0ibG9hZENvZGVzIgogICAgICAvPgogICAgPC9lbC1jYXJkPgoKICAgIDwhLS0g57uR5a6a6K6+5aSH5by556qXIC0tPgogICAgPGVsLWRpYWxvZyB2LW1vZGVsPSJiaW5kRGlhbG9nIiB0aXRsZT0i6YCJ5oup5YWz6IGU6K6+5aSHIiB3aWR0aD0iNTIwcHgiPgogICAgICA8ZWwtdGFibGUgdi1sb2FkaW5nPSJtYWNoaW5lc0xvYWRpbmciIDpkYXRhPSJhbGxNYWNoaW5lcyIgbWF4LWhlaWdodD0iMzgwIgogICAgICAgICAgICAgICAgQHNlbGVjdGlvbi1jaGFuZ2U9IihzKSA9PiAoc2VsZWN0ZWRNYWNoaW5lSWRzID0gcy5tYXAobSA9PiBtLmlkKSkiIHJlZj0ibWFjaGluZVRhYmxlUmVmIj4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIHR5cGU9InNlbGVjdGlvbiIgd2lkdGg9IjQ4IiAvPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gcHJvcD0ibWFjaGluZV9pZCIgbGFiZWw9IuiuvuWkh+e8luWPtyIgd2lkdGg9IjEzMCIgLz4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIHByb3A9Im5hbWUiIGxhYmVsPSLlkI3np7AiIC8+CiAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBsYWJlbD0i54q25oCBIiB3aWR0aD0iMTAwIj4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD0ieyByb3cgfSI+CiAgICAgICAgICAgIDxlbC10YWcgOnR5cGU9Im1hY2hpbmVTdGF0dXNUYWcocm93LnN0YXR1cykiIHNpemU9InNtYWxsIj57eyBtYWNoaW5lU3RhdHVzTGFiZWwocm93LnN0YXR1cykgfX08L2VsLXRhZz4KICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC10YWJsZS1jb2x1bW4+CiAgICAgIDwvZWwtdGFibGU+CiAgICAgIDx0ZW1wbGF0ZSAjZm9vdGVyPgogICAgICAgIDxlbC1idXR0b24gQGNsaWNrPSJiaW5kRGlhbG9nID0gZmFsc2UiPuWPlua2iDwvZWwtYnV0dG9uPgogICAgICAgIDxlbC1idXR0b24gdHlwZT0icHJpbWFyeSIgOmxvYWRpbmc9ImJpbmRTYXZpbmciIEBjbGljaz0ic3VibWl0QmluZCI+5L+d5a2YPC9lbC1idXR0b24+CiAgICAgIDwvdGVtcGxhdGU+CiAgICA8L2VsLWRpYWxvZz4KCiAgICA8IS0tIOmAieaLqeekvOWTgeW8ueeqlyAtLT4KICAgIDxlbC1kaWFsb2cgdi1tb2RlbD0icHJvZHVjdERpYWxvZyIgdGl0bGU9IumAieaLqeacrOa0u+WKqOekvOWTgSIgd2lkdGg9IjY0MHB4Ij4KICAgICAgPGVsLWlucHV0IHYtbW9kZWw9InByb2R1Y3RTZWFyY2giIHBsYWNlaG9sZGVyPSLmjInlkI3np7AvU0tVL+WTgeeJjOaQnOe0oiIgY2xlYXJhYmxlIHN0eWxlPSJ3aWR0aDoyNDBweDttYXJnaW4tYm90dG9tOjhweCIgQGlucHV0PSJsb2FkUHJvZHVjdHMiIC8+CiAgICAgIDxlbC10YWJsZSB2LWxvYWRpbmc9InByb2R1Y3RzTG9hZGluZyIgOmRhdGE9ImFsbFByb2R1Y3RzIiBtYXgtaGVpZ2h0PSIzODAiCiAgICAgICAgICAgICAgICBAc2VsZWN0aW9uLWNoYW5nZT0iKHMpID0+IChzZWxlY3RlZFByb2R1Y3RJZHMgPSBzLm1hcChwID0+IHAuaWQpKSIKICAgICAgICAgICAgICAgIHJlZj0icHJvZHVjdFRhYmxlUmVmIj4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIHR5cGU9InNlbGVjdGlvbiIgd2lkdGg9IjQ4IiAvPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gcHJvcD0ic2t1IiBsYWJlbD0iU0tVIiB3aWR0aD0iMTIwIiAvPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gcHJvcD0ibmFtZSIgbGFiZWw9IuWQjeensCIgLz4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIHByb3A9ImJyYW5kIiBsYWJlbD0i5ZOB54mMIiB3aWR0aD0iMTAwIiAvPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gbGFiZWw9IuS7k+W6kyIgd2lkdGg9IjgwIiBhbGlnbj0icmlnaHQiPgogICAgICAgICAgPHRlbXBsYXRlICNkZWZhdWx0PSJ7IHJvdyB9Ij57eyByb3cudG90YWxfc3RvY2sgfX08L3RlbXBsYXRlPgogICAgICAgIDwvZWwtdGFibGUtY29sdW1uPgogICAgICA8L2VsLXRhYmxlPgogICAgICA8dGVtcGxhdGUgI2Zvb3Rlcj4KICAgICAgICA8ZWwtYnV0dG9uIEBjbGljaz0icHJvZHVjdERpYWxvZyA9IGZhbHNlIj7lj5bmtog8L2VsLWJ1dHRvbj4KICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9InByaW1hcnkiIDpsb2FkaW5nPSJwcm9kdWN0U2F2aW5nIiBAY2xpY2s9InN1Ym1pdFByb2R1Y3RzIj7kv53lrZg8L2VsLWJ1dHRvbj4KICAgICAgPC90ZW1wbGF0ZT4KICAgIDwvZWwtZGlhbG9nPgoKICAgIDwhLS0g5om56YeP55Sf5oiQ5YWR5o2i56CBIC0tPgogICAgPGVsLWRpYWxvZyB2LW1vZGVsPSJnZW5EaWFsb2ciIHRpdGxlPSLmibnph4/nlJ/miJDlhZHmjaLnoIEiIHdpZHRoPSI0MDBweCI+CiAgICAgIDxlbC1mb3JtIGxhYmVsLXdpZHRoPSI4MHB4Ij4KICAgICAgICA8ZWwtZm9ybS1pdGVtIGxhYmVsPSLmlbDph48iPgogICAgICAgICAgPGVsLWlucHV0LW51bWJlciB2LW1vZGVsPSJnZW5Db3VudCIgOm1pbj0iMSIgOm1heD0iMTAwMDAiIC8+CiAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgICAgPGVsLWZvcm0taXRlbSBsYWJlbD0i56CB6ZW/5bqmIj4KICAgICAgICAgIDxlbC1pbnB1dCA6dmFsdWU9ImAke3Byb2plY3Q/LmNvZGVfbGVuZ3RofSDkvY3vvIjpobnnm67orr7nva7vvIlgIiBkaXNhYmxlZCAvPgogICAgICAgIDwvZWwtZm9ybS1pdGVtPgogICAgICAgIDxlbC1mb3JtLWl0ZW0gbGFiZWw9IuacieaViOacnyI+CiAgICAgICAgICA8ZWwtaW5wdXQgOnZhbHVlPSJgJHtwcm9qZWN0Py5jb2RlX3ZhbGlkaXR5X2RheXN9IOWkqe+8iOS7juatpOWIu+i1t++8iWAiIGRpc2FibGVkIC8+CiAgICAgICAgPC9lbC1mb3JtLWl0ZW0+CiAgICAgIDwvZWwtZm9ybT4KICAgICAgPHRlbXBsYXRlICNmb290ZXI+CiAgICAgICAgPGVsLWJ1dHRvbiBAY2xpY2s9ImdlbkRpYWxvZyA9IGZhbHNlIj7lj5bmtog8L2VsLWJ1dHRvbj4KICAgICAgICA8ZWwtYnV0dG9uIHR5cGU9InByaW1hcnkiIDpsb2FkaW5nPSJnZW5TYXZpbmciIEBjbGljaz0ic3VibWl0R2VuIj7nlJ/miJA8L2VsLWJ1dHRvbj4KICAgICAgPC90ZW1wbGF0ZT4KICAgIDwvZWwtZGlhbG9nPgoKICAgIDwhLS0gPT09PT0g5Y+R5biD5YmN6Ieq5qOAIGRpYWxvZyA9PT09PSAtLT4KICAgIDxlbC1kaWFsb2cgdi1tb2RlbD0icHJlZmxpZ2h0RGlhbG9nIiB0aXRsZT0i5Y+R5biD5LiK57q/IMK3IOWJjee9ruiHquajgCIgd2lkdGg9IjUyMHB4Ij4KICAgICAgPGRpdiB2LWlmPSJwcmVmbGlnaHREYXRhIj4KICAgICAgICA8ZWwtYWxlcnQKICAgICAgICAgIHYtaWY9IiFwcmVmbGlnaHREYXRhLmNhbl9wdWJsaXNoIgogICAgICAgICAgdHlwZT0iZXJyb3IiIDpjbG9zYWJsZT0iZmFsc2UiIHNob3ctaWNvbgogICAgICAgICAgdGl0bGU9IuWtmOWcqOW/hemhu+S/ruWkjeeahOmXrumimO+8iGJsb2Nr77yJ77yM5peg5rOV5Y+R5biDIgogICAgICAgICAgc3R5bGU9Im1hcmdpbi1ib3R0b206MTRweCIKICAgICAgICAvPgogICAgICAgIDxlbC1hbGVydAogICAgICAgICAgdi1lbHNlLWlmPSJwcmVmbGlnaHRXYXJuaW5ncy5sZW5ndGgiCiAgICAgICAgICB0eXBlPSJ3YXJuaW5nIiA6Y2xvc2FibGU9ImZhbHNlIiBzaG93LWljb24KICAgICAgICAgIHRpdGxlPSLmnInorablkYrpobnvvIh3YXJu77yJ77yM5Y+v5by65Yi25Y+R5biDIgogICAgICAgICAgc3R5bGU9Im1hcmdpbi1ib3R0b206MTRweCIKICAgICAgICAvPgogICAgICAgIDxlbC1hbGVydAogICAgICAgICAgdi1lbHNlCiAgICAgICAgICB0eXBlPSJzdWNjZXNzIiA6Y2xvc2FibGU9ImZhbHNlIiBzaG93LWljb24KICAgICAgICAgIHRpdGxlPSLlhajpg6jmo4Dmn6XpgJrov4ciCiAgICAgICAgICBzdHlsZT0ibWFyZ2luLWJvdHRvbToxNHB4IgogICAgICAgIC8+CgogICAgICAgIDxkaXYgdi1mb3I9ImMgaW4gcHJlZmxpZ2h0RGF0YS5jaGVja3MiIDprZXk9ImMua2V5IiBjbGFzcz0icHJlZmxpZ2h0LXJvdyI+CiAgICAgICAgICA8ZWwtaWNvbiB2LWlmPSJjLm9rIiBjbGFzcz0ib2staWNvbiI+PENpcmNsZUNoZWNrRmlsbGVkIC8+PC9lbC1pY29uPgogICAgICAgICAgPGVsLWljb24gdi1lbHNlLWlmPSJjLnNldmVyaXR5ID09PSAnYmxvY2snIiBjbGFzcz0iYmxvY2staWNvbiI+PENpcmNsZUNsb3NlRmlsbGVkIC8+PC9lbC1pY29uPgogICAgICAgICAgPGVsLWljb24gdi1lbHNlIGNsYXNzPSJ3YXJuLWljb24iPjxXYXJuaW5nRmlsbGVkIC8+PC9lbC1pY29uPgogICAgICAgICAgPGRpdiBjbGFzcz0icHJlZmxpZ2h0LWJvZHkiPgogICAgICAgICAgICA8ZGl2IGNsYXNzPSJwcmVmbGlnaHQtbGFiZWwiPnt7IGMubGFiZWwgfX08L2Rpdj4KICAgICAgICAgICAgPGRpdiB2LWlmPSJjLmRldGFpbCIgY2xhc3M9InByZWZsaWdodC1kZXRhaWwiPnt7IGMuZGV0YWlsIH19PC9kaXY+CiAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDxlbC10YWcgdi1pZj0iIWMub2siIDp0eXBlPSJjLnNldmVyaXR5ID09PSAnYmxvY2snID8gJ2RhbmdlcicgOiAnd2FybmluZyciIHNpemU9InNtYWxsIj4KICAgICAgICAgICAge3sgYy5zZXZlcml0eSA9PT0gJ2Jsb2NrJyA/ICflv4Xpobvkv67lpI0nIDogJ+W7uuiuruWkhOeQhicgfX0KICAgICAgICAgIDwvZWwtdGFnPgogICAgICAgIDwvZGl2PgogICAgICA8L2Rpdj4KCiAgICAgIDx0ZW1wbGF0ZSAjZm9vdGVyPgogICAgICAgIDxlbC1idXR0b24gQGNsaWNrPSJwcmVmbGlnaHREaWFsb2cgPSBmYWxzZSI+5Y+W5raIPC9lbC1idXR0b24+CiAgICAgICAgPGVsLWJ1dHRvbgogICAgICAgICAgdi1pZj0icHJlZmxpZ2h0RGF0YT8uY2FuX3B1Ymxpc2giCiAgICAgICAgICB0eXBlPSJzdWNjZXNzIiA6bG9hZGluZz0idHJhbnNpdGlvbmluZyIKICAgICAgICAgIEBjbGljaz0iZG9QdWJsaXNoKHByZWZsaWdodFdhcm5pbmdzLmxlbmd0aCA+IDApIj4KICAgICAgICAgIHt7IHByZWZsaWdodFdhcm5pbmdzLmxlbmd0aCA+IDAgPyAn5b+955Wl6K2m5ZGK77yM5by65Yi25Y+R5biDJyA6ICfnq4vljbPlj5HluIMnIH19CiAgICAgICAgPC9lbC1idXR0b24+CiAgICAgIDwvdGVtcGxhdGU+CiAgICA8L2VsLWRpYWxvZz4KICA8L2Rpdj4KPC90ZW1wbGF0ZT4KCjxzY3JpcHQgc2V0dXA+CmltcG9ydCB7IHJlZiwgcmVhY3RpdmUsIGNvbXB1dGVkLCBvbk1vdW50ZWQsIG5leHRUaWNrIH0gZnJvbSAndnVlJwppbXBvcnQgeyB1c2VSb3V0ZSB9IGZyb20gJ3Z1ZS1yb3V0ZXInCmltcG9ydCB7IEVsTWVzc2FnZSB9IGZyb20gJ2VsZW1lbnQtcGx1cycKaW1wb3J0IHsKICBBcnJvd0xlZnQsIFJlZnJlc2gsIEVkaXQsIFBsdXMsIExpbmssIE1hZ2ljU3RpY2ssIFVzZXIsCiAgVmlkZW9QbGF5LCBWaWRlb1BhdXNlLCBDaXJjbGVDbG9zZSwKICBDaXJjbGVDaGVja0ZpbGxlZCwgQ2lyY2xlQ2xvc2VGaWxsZWQsIFdhcm5pbmdGaWxsZWQsIERlbGV0ZQp9IGZyb20gJ0BlbGVtZW50LXBsdXMvaWNvbnMtdnVlJwppbXBvcnQgeyBFbE1lc3NhZ2VCb3ggfSBmcm9tICdlbGVtZW50LXBsdXMnCmltcG9ydCBBY2Nlc3NVcmxDYXJkIGZyb20gJ0AvY29tcG9uZW50cy9BY2Nlc3NVcmxDYXJkLnZ1ZScKaW1wb3J0IHsgdXNlU3lzdGVtU3RvcmUgfSBmcm9tICdAL3N0b3Jlcy9zeXN0ZW0nCgpjb25zdCBzeXMgPSB1c2VTeXN0ZW1TdG9yZSgpCmltcG9ydCB7CiAgZ2V0UHJvamVjdCwgYmluZE1hY2hpbmVzLCBiaW5kUHJvZHVjdHMsIGdlbmVyYXRlQ29kZXMsCiAgbGlzdFJlZGVlbUNvZGVzLCByZXZva2VDb2RlLCBkZWxldGVSZWRlZW1Db2RlLAogIHByZWZsaWdodFByb2plY3QsIHRyYW5zaXRpb25Qcm9qZWN0Cn0gZnJvbSAnQC9hcGkvcHJvamVjdHMnCmltcG9ydCB7IGxpc3RNYWNoaW5lcyB9IGZyb20gJ0AvYXBpL2RldmljZXMnCmltcG9ydCB7IGxpc3RQcm9kdWN0cyB9IGZyb20gJ0AvYXBpL3Byb2R1Y3RzJwoKY29uc3Qgcm91dGUgPSB1c2VSb3V0ZSgpCmNvbnN0IGlkID0gcm91dGUucGFyYW1zLmlkCgpjb25zdCBsb2FkaW5nID0gcmVmKGZhbHNlKQpjb25zdCBwcm9qZWN0ID0gcmVmKG51bGwpCgphc3luYyBmdW5jdGlvbiByZWxvYWQoKSB7CiAgbG9hZGluZy52YWx1ZSA9IHRydWUKICB0cnkgewogICAgcHJvamVjdC52YWx1ZSA9IGF3YWl0IGdldFByb2plY3QoaWQpCiAgICBhd2FpdCBsb2FkQ29kZXMoKQogIH0gZmluYWxseSB7CiAgICBsb2FkaW5nLnZhbHVlID0gZmFsc2UKICB9Cn0Kb25Nb3VudGVkKHJlbG9hZCkKCi8vID09PT09PT09PT09PSDpobnnm67nirbmgIHovaznp7sgPT09PT09PT09PT09CmNvbnN0IHRyYW5zaXRpb25pbmcgPSByZWYoZmFsc2UpCmNvbnN0IHByZWZsaWdodERpYWxvZyA9IHJlZihmYWxzZSkKY29uc3QgcHJlZmxpZ2h0RGF0YSA9IHJlZihudWxsKQpjb25zdCBwcmVmbGlnaHRXYXJuaW5ncyA9IGNvbXB1dGVkKAogICgpID0+IHByZWZsaWdodERhdGEudmFsdWU/LmNoZWNrcy5maWx0ZXIoYyA9PiAhYy5vayAmJiBjLnNldmVyaXR5ID09PSAnd2FybicpIHx8IFtdCikKCmFzeW5jIGZ1bmN0aW9uIG9uUHVibGlzaCgpIHsKICAvLyBkcmFmdCDihpIgcnVubmluZ++8jOW8ueiHquajgAogIHRyYW5zaXRpb25pbmcudmFsdWUgPSB0cnVlCiAgdHJ5IHsKICAgIHByZWZsaWdodERhdGEudmFsdWUgPSBhd2FpdCBwcmVmbGlnaHRQcm9qZWN0KGlkKQogICAgcHJlZmxpZ2h0RGlhbG9nLnZhbHVlID0gdHJ1ZQogIH0gZmluYWxseSB7CiAgICB0cmFuc2l0aW9uaW5nLnZhbHVlID0gZmFsc2UKICB9Cn0KCmFzeW5jIGZ1bmN0aW9uIGRvUHVibGlzaChmb3JjZSkgewogIHRyYW5zaXRpb25pbmcudmFsdWUgPSB0cnVlCiAgdHJ5IHsKICAgIGF3YWl0IHRyYW5zaXRpb25Qcm9qZWN0KGlkLCAncnVubmluZycsIGZvcmNlKQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoJ+W3suWPkeW4g+S4iue6v++8jEMg56uv5Y+v6aKG56CBJykKICAgIHByZWZsaWdodERpYWxvZy52YWx1ZSA9IGZhbHNlCiAgICBhd2FpdCByZWxvYWQoKQogIH0gZmluYWxseSB7CiAgICB0cmFuc2l0aW9uaW5nLnZhbHVlID0gZmFsc2UKICB9Cn0KCmFzeW5jIGZ1bmN0aW9uIG9uVHJhbnNpdGlvbih0YXJnZXQpIHsKICBjb25zdCBsYWJlbHMgPSB7IHJ1bm5pbmc6ICfnu6fnu63mtLvliqgnLCBwYXVzZWQ6ICfmmoLlgZzmtLvliqgnLCBmaW5pc2hlZDogJ+e7k+adn+a0u+WKqCcgfQogIGNvbnN0IHdhcm5zID0gewogICAgcGF1c2VkOiAn5pqC5YGc5ZCOIEMg56uv5bCG5peg5rOV6aKG56CB77yM5bey5Y+R5Ye655qE5YWR5o2i56CB5LuN5Y+v5Zyo5rS+5qC35py65L2/55So44CC56Gu6K6k77yfJywKICAgIGZpbmlzaGVkOiAn57uT5p2f5ZCO5LiN5Y+v5YaN5YiH5ZueIHJ1bm5pbmfvvIjnu4jmgIHvvInjgILlu7rorq7noa7orqTml6DpgZfnlZnlhZHmjaLnoIHjgILnoa7orqTvvJ8nLAogICAgcnVubmluZzogJ+Wwhueri+WNs+aBouWkjSBDIOerr+mihueggeOAguehruiupO+8nycsCiAgfQogIHRyeSB7CiAgICBhd2FpdCBFbE1lc3NhZ2VCb3guY29uZmlybSh3YXJuc1t0YXJnZXRdLCBsYWJlbHNbdGFyZ2V0XSwgewogICAgICB0eXBlOiB0YXJnZXQgPT09ICdmaW5pc2hlZCcgPyAnd2FybmluZycgOiAnaW5mbycsCiAgICAgIGNvbmZpcm1CdXR0b25UZXh0OiAn56Gu5a6aJywgY2FuY2VsQnV0dG9uVGV4dDogJ+WPlua2iCcKICAgIH0pCiAgICB0cmFuc2l0aW9uaW5nLnZhbHVlID0gdHJ1ZQogICAgYXdhaXQgdHJhbnNpdGlvblByb2plY3QoaWQsIHRhcmdldCkKICAgIEVsTWVzc2FnZS5zdWNjZXNzKGDlt7LliIfmjaLliLDjgIwkeyh7cnVubmluZzon6L+b6KGM5LitJyxwYXVzZWQ6J+W3suaaguWBnCcsZmluaXNoZWQ6J+W3sue7k+adnyd9KVt0YXJnZXRdfeOAjWApCiAgICBhd2FpdCByZWxvYWQoKQogIH0gY2F0Y2ggKGUpIHsKICAgIGlmIChlICE9PSAnY2FuY2VsJykgdGhyb3cgZQogIH0gZmluYWxseSB7CiAgICB0cmFuc2l0aW9uaW5nLnZhbHVlID0gZmFsc2UKICB9Cn0KCmZ1bmN0aW9uIHN0YXR1c1RhZyhzKSB7IHJldHVybiAoeyBkcmFmdDonaW5mbycsIHJ1bm5pbmc6J3N1Y2Nlc3MnLCBwYXVzZWQ6J3dhcm5pbmcnLCBmaW5pc2hlZDonJyB9KVtzXSB8fCAnaW5mbycgfQpmdW5jdGlvbiBzdGF0dXNMYWJlbChzKSB7IHJldHVybiAoeyBkcmFmdDon6I2J56i/JywgcnVubmluZzon6L+b6KGM5LitJywgcGF1c2VkOiflt7LmmoLlgZwnLCBmaW5pc2hlZDon5bey57uT5p2fJyB9KVtzXSB8fCBzIH0KZnVuY3Rpb24gbWFjaGluZVN0YXR1c1RhZyhzKSB7IHJldHVybiAoeyBvbmxpbmU6J3N1Y2Nlc3MnLCBvZmZsaW5lOidpbmZvJywgZmF1bHQ6J2RhbmdlcicgfSlbc10gfHwgJ2luZm8nIH0KZnVuY3Rpb24gbWFjaGluZVN0YXR1c0xhYmVsKHMpIHsgcmV0dXJuICh7IG9ubGluZTon5Zyo57q/Jywgb2ZmbGluZTon56a757q/JywgZmF1bHQ6J+aVhemanCcgfSlbc10gfHwgcyB9CmZ1bmN0aW9uIGNvZGVTdGF0dXNUYWcocykgeyByZXR1cm4gKHsgdW51c2VkOidzdWNjZXNzJywgdXNlZDonaW5mbycsIGV4cGlyZWQ6J3dhcm5pbmcnLCByZXZva2VkOidkYW5nZXInIH0pW3NdIHx8ICdpbmZvJyB9CmZ1bmN0aW9uIGZvcm1hdFRpbWUoaXNvKSB7IHJldHVybiBpc28gPyBuZXcgRGF0ZShpc28pLnRvTG9jYWxlU3RyaW5nKCd6aC1DTicsIHsgaG91cjEyOiBmYWxzZSB9KSA6ICfigJQnIH0KCmZ1bmN0aW9uIG9wZW5INSgpIHsKICBjb25zdCBiYXNlID0gd2luZG93LmxvY2F0aW9uLm9yaWdpbi5yZXBsYWNlKCc6NTE3MycsICc6ODAwMCcpCiAgY29uc3QgbWlkID0gcHJvamVjdC52YWx1ZS5tYWNoaW5lc1swXT8ubWFjaGluZV9pZAogIGNvbnN0IHVybCA9IG1pZCA/IGAke2Jhc2V9L3AvJHtwcm9qZWN0LnZhbHVlLmlkfS8/bWFjaGluZV9pZD0ke21pZH1gIDogYCR7YmFzZX0vcC8ke3Byb2plY3QudmFsdWUuaWR9L2AKICB3aW5kb3cub3Blbih1cmwsICdfYmxhbmsnKQp9CgovLyAtLS0tIOWuouaIt+err+eci+advyAtLS0tCmZ1bmN0aW9uIGNvcHlDbGllbnRVcmwoKSB7CiAgY29uc3QgdXJsID0gcHJvamVjdC52YWx1ZS5jbGllbnRfdXJsCiAgaWYgKCF1cmwpIHJldHVybgogIG5hdmlnYXRvci5jbGlwYm9hcmQud3JpdGVUZXh0KHVybCkudGhlbigoKSA9PiB7CiAgICBFbE1lc3NhZ2Uuc3VjY2Vzcygn5a6i5oi356uv6ZO+5o6l5bey5aSN5Yi277yM5Y+v5Y+R6YCB57uZ5a6i5oi355Sy5pa5JykKICB9KS5jYXRjaCgoKSA9PiB7CiAgICBjb25zdCB0YSA9IGRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoJ3RleHRhcmVhJykKICAgIHRhLnZhbHVlID0gdXJsCiAgICB0YS5zdHlsZS5wb3NpdGlvbiA9ICdmaXhlZCc7IHRhLnN0eWxlLmxlZnQgPSAnLTk5OTlweCcKICAgIGRvY3VtZW50LmJvZHkuYXBwZW5kQ2hpbGQodGEpOyB0YS5zZWxlY3QoKQogICAgZG9jdW1lbnQuZXhlY0NvbW1hbmQoJ2NvcHknKQogICAgZG9jdW1lbnQuYm9keS5yZW1vdmVDaGlsZCh0YSkKICAgIEVsTWVzc2FnZS5zdWNjZXNzKCflrqLmiLfnq6/pk77mjqXlt7LlpI3liLYnKQogIH0pCn0KCmZ1bmN0aW9uIG9wZW5DbGllbnRVcmwoKSB7CiAgd2luZG93Lm9wZW4ocHJvamVjdC52YWx1ZS5jbGllbnRfdXJsLCAnX2JsYW5rJykKfQoKLy8gLS0tLSDlhZHmjaLnoIHliJfooaggLS0tLQpjb25zdCBjb2RlcyA9IHJlZihbXSkKY29uc3QgY29kZUZpbHRlciA9IHJlZignJykKY29uc3QgY29kZUxvYWRpbmcgPSByZWYoZmFsc2UpCmNvbnN0IGNvZGVQYWdlID0gcmVhY3RpdmUoeyBjdXJyZW50OiAxLCBwYWdlU2l6ZTogNTAsIHRvdGFsOiAwIH0pCmNvbnN0IGNvZGVUb3RhbCA9IGNvbXB1dGVkKCgpID0+IGNvZGVQYWdlLnRvdGFsKQpjb25zdCBjb2RlVXNlZCA9IGNvbXB1dGVkKCgpID0+CiAgY29kZXMudmFsdWUuZmlsdGVyKGMgPT4gYy5zdGF0dXMgPT09ICd1c2VkJykubGVuZ3RoIC8vIOS7heW9k+WJjemhtee7n+iuoe+8jOWujOaVtOe7n+iuoei1sCBwcm9qZWN0IOWIl+ihqCBhZ2dyZWdhdGUKKQpjb25zdCBzZWxlY3RlZENvZGVJZHMgPSByZWYoW10pCmZ1bmN0aW9uIG9uQ29kZVNlbGVjdGlvbkNoYW5nZShyb3dzKSB7CiAgc2VsZWN0ZWRDb2RlSWRzLnZhbHVlID0gcm93cy5tYXAociA9PiByLmlkKQp9CmFzeW5jIGZ1bmN0aW9uIGxvYWRDb2RlcygpIHsKICBjb2RlTG9hZGluZy52YWx1ZSA9IHRydWUKICB0cnkgewogICAgY29uc3QgZGF0YSA9IGF3YWl0IGxpc3RSZWRlZW1Db2Rlcyh7CiAgICAgIHByb2plY3Q6IGlkLAogICAgICBzdGF0dXM6IGNvZGVGaWx0ZXIudmFsdWUgfHwgdW5kZWZpbmVkLAogICAgICBwYWdlOiBjb2RlUGFnZS5jdXJyZW50LAogICAgICBwYWdlX3NpemU6IGNvZGVQYWdlLnBhZ2VTaXplCiAgICB9KQogICAgY29kZXMudmFsdWUgPSBkYXRhLnJlc3VsdHMgfHwgZGF0YQogICAgY29kZVBhZ2UudG90YWwgPSBkYXRhLmNvdW50ID8/IGNvZGVzLnZhbHVlLmxlbmd0aAogIH0gZmluYWxseSB7CiAgICBjb2RlTG9hZGluZy52YWx1ZSA9IGZhbHNlCiAgfQp9CmFzeW5jIGZ1bmN0aW9uIGRvUmV2b2tlKHJvdykgewogIGF3YWl0IHJldm9rZUNvZGUocm93LmlkKQogIEVsTWVzc2FnZS5zdWNjZXNzKCflt7LkvZzlup8nKQogIGF3YWl0IGxvYWRDb2RlcygpCn0KYXN5bmMgZnVuY3Rpb24gZG9EZWxldGVDb2RlKHJvdykgewogIGF3YWl0IEVsTWVzc2FnZUJveC5jb25maXJtKAogICAgYOehruWumuWIoOmZpOWFkeaNoueggSAke3Jvdy5jb2Rlfe+8n+ivpeaTjeS9nOS4jeWPr+aBouWkjeOAgmAsCiAgICAn56Gu6K6kJywKICAgIHsgdHlwZTogJ3dhcm5pbmcnIH0KICApCiAgYXdhaXQgZGVsZXRlUmVkZWVtQ29kZShyb3cuaWQpCiAgRWxNZXNzYWdlLnN1Y2Nlc3MoJ+W3suWIoOmZpCcpCiAgYXdhaXQgbG9hZENvZGVzKCkKfQphc3luYyBmdW5jdGlvbiBiYXRjaERlbGV0ZUNvZGVzKCkgewogIGNvbnN0IGlkcyA9IHNlbGVjdGVkQ29kZUlkcy52YWx1ZQogIGlmICghaWRzLmxlbmd0aCkgcmV0dXJuCiAgYXdhaXQgRWxNZXNzYWdlQm94LmNvbmZpcm0oCiAgICBg56Gu5a6a5om56YeP5Yig6ZmkICR7aWRzLmxlbmd0aH0g5p2h5YWR5o2i56CB77yf6K+l5pON5L2c5LiN5Y+v5oGi5aSN44CCYCwKICAgICfnoa7orqQnLAogICAgeyB0eXBlOiAnd2FybmluZycgfQogICkKICBjb25zdCByZXN1bHRzID0gYXdhaXQgUHJvbWlzZS5hbGxTZXR0bGVkKGlkcy5tYXAoaWQgPT4gZGVsZXRlUmVkZWVtQ29kZShpZCkpKQogIGNvbnN0IG9rID0gcmVzdWx0cy5maWx0ZXIociA9PiByLnN0YXR1cyA9PT0gJ2Z1bGZpbGxlZCcpLmxlbmd0aAogIGNvbnN0IGZhaWwgPSByZXN1bHRzLmxlbmd0aCAtIG9rCiAgc2VsZWN0ZWRDb2RlSWRzLnZhbHVlID0gW10KICBhd2FpdCBsb2FkQ29kZXMoKQogIGlmIChmYWlsID09PSAwKSB7CiAgICBFbE1lc3NhZ2Uuc3VjY2Vzcyhg5bey5Yig6ZmkICR7b2t9IOadoWApCiAgfSBlbHNlIHsKICAgIEVsTWVzc2FnZS53YXJuaW5nKGDliKDpmaTlrozmiJDvvJrmiJDlip8gJHtva30g5p2h77yM5aSx6LSlICR7ZmFpbH0g5p2hYCkKICB9Cn0KCi8vIC0tLS0g57uR5a6a6K6+5aSHIC0tLS0KY29uc3QgYmluZERpYWxvZyA9IHJlZihmYWxzZSkKY29uc3QgbWFjaGluZXNMb2FkaW5nID0gcmVmKGZhbHNlKQpjb25zdCBhbGxNYWNoaW5lcyA9IHJlZihbXSkKY29uc3Qgc2VsZWN0ZWRNYWNoaW5lSWRzID0gcmVmKFtdKQpjb25zdCBtYWNoaW5lVGFibGVSZWYgPSByZWYoKQpjb25zdCBiaW5kU2F2aW5nID0gcmVmKGZhbHNlKQoKYXN5bmMgZnVuY3Rpb24gb3BlbkJpbmREaWFsb2coKSB7CiAgYmluZERpYWxvZy52YWx1ZSA9IHRydWUKICBtYWNoaW5lc0xvYWRpbmcudmFsdWUgPSB0cnVlCiAgdHJ5IHsKICAgIGNvbnN0IGRhdGEgPSBhd2FpdCBsaXN0TWFjaGluZXMoeyBwYWdlX3NpemU6IDUwMCB9KQogICAgYWxsTWFjaGluZXMudmFsdWUgPSBkYXRhLnJlc3VsdHMgfHwgZGF0YQogICAgLy8g5Yu+6YCJ5b2T5YmN5bey57uRCiAgICBhd2FpdCBuZXh0VGljaygpCiAgICBjb25zdCBib3VuZElkcyA9IG5ldyBTZXQocHJvamVjdC52YWx1ZS5tYWNoaW5lcy5tYXAobSA9PiBtLmlkKSkKICAgIGFsbE1hY2hpbmVzLnZhbHVlLmZvckVhY2gobSA9PiB7CiAgICAgIG1hY2hpbmVUYWJsZVJlZi52YWx1ZT8udG9nZ2xlUm93U2VsZWN0aW9uKG0sIGJvdW5kSWRzLmhhcyhtLmlkKSkKICAgIH0pCiAgfSBmaW5hbGx5IHsKICAgIG1hY2hpbmVzTG9hZGluZy52YWx1ZSA9IGZhbHNlCiAgfQp9CmFzeW5jIGZ1bmN0aW9uIHN1Ym1pdEJpbmQoKSB7CiAgYmluZFNhdmluZy52YWx1ZSA9IHRydWUKICB0cnkgewogICAgcHJvamVjdC52YWx1ZSA9IGF3YWl0IGJpbmRNYWNoaW5lcyhpZCwgc2VsZWN0ZWRNYWNoaW5lSWRzLnZhbHVlKQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoYOW3sue7keWumiAke3Byb2plY3QudmFsdWUubWFjaGluZXMubGVuZ3RofSDlj7Dorr7lpIdgKQogICAgYmluZERpYWxvZy52YWx1ZSA9IGZhbHNlCiAgfSBmaW5hbGx5IHsKICAgIGJpbmRTYXZpbmcudmFsdWUgPSBmYWxzZQogIH0KfQoKLy8gLS0tLSDmjILovb3npLzlk4EgLS0tLQpjb25zdCBwcm9kdWN0RGlhbG9nID0gcmVmKGZhbHNlKQpjb25zdCBwcm9kdWN0c0xvYWRpbmcgPSByZWYoZmFsc2UpCmNvbnN0IGFsbFByb2R1Y3RzID0gcmVmKFtdKQpjb25zdCBzZWxlY3RlZFByb2R1Y3RJZHMgPSByZWYoW10pCmNvbnN0IHByb2R1Y3RTZWFyY2ggPSByZWYoJycpCmNvbnN0IHByb2R1Y3RUYWJsZVJlZiA9IHJlZigpCmNvbnN0IHByb2R1Y3RTYXZpbmcgPSByZWYoZmFsc2UpCgphc3luYyBmdW5jdGlvbiBsb2FkUHJvZHVjdHMoKSB7CiAgcHJvZHVjdHNMb2FkaW5nLnZhbHVlID0gdHJ1ZQogIHRyeSB7CiAgICBjb25zdCBkYXRhID0gYXdhaXQgbGlzdFByb2R1Y3RzKHsgc2VhcmNoOiBwcm9kdWN0U2VhcmNoLnZhbHVlLCBwYWdlX3NpemU6IDIwMCB9KQogICAgYWxsUHJvZHVjdHMudmFsdWUgPSBkYXRhLnJlc3VsdHMgfHwgZGF0YQogICAgYXdhaXQgbmV4dFRpY2soKQogICAgY29uc3QgYm91bmRJZHMgPSBuZXcgU2V0KChwcm9qZWN0LnZhbHVlLnByb2R1Y3RzIHx8IFtdKS5tYXAocCA9PiBwLmlkKSkKICAgIGFsbFByb2R1Y3RzLnZhbHVlLmZvckVhY2gocCA9PiB7CiAgICAgIHByb2R1Y3RUYWJsZVJlZi52YWx1ZT8udG9nZ2xlUm93U2VsZWN0aW9uKHAsIGJvdW5kSWRzLmhhcyhwLmlkKSkKICAgIH0pCiAgfSBmaW5hbGx5IHsKICAgIHByb2R1Y3RzTG9hZGluZy52YWx1ZSA9IGZhbHNlCiAgfQp9CmFzeW5jIGZ1bmN0aW9uIG9wZW5Qcm9kdWN0RGlhbG9nKCkgewogIHByb2R1Y3REaWFsb2cudmFsdWUgPSB0cnVlCiAgcHJvZHVjdFNlYXJjaC52YWx1ZSA9ICcnCiAgYXdhaXQgbG9hZFByb2R1Y3RzKCkKfQphc3luYyBmdW5jdGlvbiBzdWJtaXRQcm9kdWN0cygpIHsKICBwcm9kdWN0U2F2aW5nLnZhbHVlID0gdHJ1ZQogIHRyeSB7CiAgICBwcm9qZWN0LnZhbHVlID0gYXdhaXQgYmluZFByb2R1Y3RzKGlkLCBzZWxlY3RlZFByb2R1Y3RJZHMudmFsdWUpCiAgICBFbE1lc3NhZ2Uuc3VjY2Vzcyhg5bey5oyC6L29ICR7cHJvamVjdC52YWx1ZS5wcm9kdWN0cy5sZW5ndGh9IOS4quekvOWTgWApCiAgICBwcm9kdWN0RGlhbG9nLnZhbHVlID0gZmFsc2UKICB9IGZpbmFsbHkgewogICAgcHJvZHVjdFNhdmluZy52YWx1ZSA9IGZhbHNlCiAgfQp9CgovLyAtLS0tIOeUn+aIkOWFkeaNoueggSAtLS0tCmNvbnN0IGdlbkRpYWxvZyA9IHJlZihmYWxzZSkKY29uc3QgZ2VuQ291bnQgPSByZWYoNTApCmNvbnN0IGdlblNhdmluZyA9IHJlZihmYWxzZSkKZnVuY3Rpb24gb3BlbkdlbkRpYWxvZygpIHsKICBnZW5Db3VudC52YWx1ZSA9IDUwCiAgZ2VuRGlhbG9nLnZhbHVlID0gdHJ1ZQp9CmFzeW5jIGZ1bmN0aW9uIHN1Ym1pdEdlbigpIHsKICBnZW5TYXZpbmcudmFsdWUgPSB0cnVlCiAgdHJ5IHsKICAgIGNvbnN0IHJlcyA9IGF3YWl0IGdlbmVyYXRlQ29kZXMoaWQsIGdlbkNvdW50LnZhbHVlKQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoYOW3sueUn+aIkCAke3Jlcy5jcmVhdGVkfSAvICR7cmVzLnJlcXVlc3RlZH0g5Liq5YWR5o2i56CBYCkKICAgIGdlbkRpYWxvZy52YWx1ZSA9IGZhbHNlCiAgICBjb2RlRmlsdGVyLnZhbHVlID0gJ3VudXNlZCcKICAgIGNvZGVQYWdlLmN1cnJlbnQgPSAxCiAgICBhd2FpdCBsb2FkQ29kZXMoKQogIH0gZmluYWxseSB7CiAgICBnZW5TYXZpbmcudmFsdWUgPSBmYWxzZQogIH0KfQo8L3NjcmlwdD4KCjxzdHlsZSBsYW5nPSJzY3NzIiBzY29wZWQ+Ci5wcm9qZWN0LWRldGFpbCB7IGRpc3BsYXk6ZmxleDsgZmxleC1kaXJlY3Rpb246Y29sdW1uOyBnYXA6MTZweDsgfQouaW5mby1jYXJkIHsgYmFja2dyb3VuZDojMWExZjJjOyBib3JkZXI6MXB4IHNvbGlkICMyYTMxNDI7CiAgOmRlZXAoLmVsLWNhcmRfX2hlYWRlcil7IGJvcmRlci1ib3R0b206MXB4IHNvbGlkICMyYTMxNDI7IH0gfQouaGVhZGVyLXJvdyB7IGRpc3BsYXk6ZmxleDsgYWxpZ24taXRlbXM6Y2VudGVyOyBnYXA6MTJweDsKICAudGl0bGUgeyBmb250LXNpemU6MTVweDsgY29sb3I6I2U2ZTZlNjsgZm9udC13ZWlnaHQ6NTAwOyB9CiAgLnNwYWNlciB7IGZsZXg6MTsgfSB9Ci5ydWxlcyB7IG1hcmdpbjowOyB3aGl0ZS1zcGFjZTpwcmUtd3JhcDsgZm9udC1mYW1pbHk6aW5oZXJpdDsgY29sb3I6I2MwYzRjYzsgfQouY29kZS1jZWxsIHsgYmFja2dyb3VuZDojMGYxNDE5OyBib3JkZXI6MXB4IHNvbGlkICMyYTMxNDI7IHBhZGRpbmc6MnB4IDhweDsgYm9yZGVyLXJhZGl1czo0cHg7CiAgZm9udC1mYW1pbHk6IHVpLW1vbm9zcGFjZSwgTWVubG8sIENvbnNvbGFzLCBtb25vc3BhY2U7IGNvbG9yOiM2N2MyM2E7IH0KCi8qIOWPkeW4g+WJjeiHquajgCAqLwoucHJlZmxpZ2h0LXJvdyB7CiAgZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IGNlbnRlcjsgZ2FwOiAxMnB4OwogIHBhZGRpbmc6IDEwcHggMTJweDsgbWFyZ2luLWJvdHRvbTogOHB4OwogIGJhY2tncm91bmQ6ICMwZjE0MTk7IGJvcmRlcjogMXB4IHNvbGlkICMyYTMxNDI7IGJvcmRlci1yYWRpdXM6IDhweDsKICAucHJlZmxpZ2h0LWJvZHkgeyBmbGV4OiAxOyBtaW4td2lkdGg6IDA7IH0KICAucHJlZmxpZ2h0LWxhYmVsIHsgY29sb3I6ICNlNmU2ZTY7IGZvbnQtc2l6ZTogMTRweDsgfQogIC5wcmVmbGlnaHQtZGV0YWlsIHsgY29sb3I6ICM5MDkzOTk7IGZvbnQtc2l6ZTogMTJweDsgbWFyZ2luLXRvcDogMnB4OyB9CiAgLm9rLWljb24gICAgeyBjb2xvcjogIzY3YzIzYTsgZm9udC1zaXplOiAyMHB4OyB9CiAgLmJsb2NrLWljb24geyBjb2xvcjogI2Y1NmM2YzsgZm9udC1zaXplOiAyMHB4OyB9CiAgLndhcm4taWNvbiAgeyBjb2xvcjogI2U2YTIzYzsgZm9udC1zaXplOiAyMHB4OyB9Cn0KLmNsaWVudC11cmwtcm93IHsKICBkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogY2VudGVyOyBnYXA6IDEycHg7Cn0KLmNsaWVudC11cmwtcm93IC51cmwtdGV4dCB7CiAgZmxleDogMTsgYmFja2dyb3VuZDogIzBmMTQxOTsgYm9yZGVyOiAxcHggc29saWQgIzJhMzE0MjsKICBwYWRkaW5nOiA4cHggMTJweDsgYm9yZGVyLXJhZGl1czogNnB4OwogIGZvbnQtZmFtaWx5OiB1aS1tb25vc3BhY2UsIG1vbm9zcGFjZTsgZm9udC1zaXplOiAxM3B4OwogIGNvbG9yOiAjNjdjMjNhOyB3b3JkLWJyZWFrOiBicmVhay1hbGw7Cn0KLnVuc2V0LXJvdyB7CiAgY29sb3I6ICM2MDYyNjY7IGZvbnQtc2l6ZTogMTNweDsgcGFkZGluZzogMTZweCAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7Cn0KPC9zdHlsZT4K
B64EOF

ls -la /tmp/projects.js.b64 /tmp/ProjectDetail.vue.b64 2>&1; md5sum /tmp/projects.js.b64 /tmp/ProjectDetail.vue.b64 2>&1; echo MARKER_END_UP
exit
cat > /tmp/deployfe.sh << 'REMOTE_EOF'
set -e
cd /opt/gush2
TS=$(date +%Y%m%d-%H%M%S)
SNAP_DIR=/home/ubuntu/gush2-snapshots/$TS
mkdir -p $SNAP_DIR

echo ---A.snapshot---
tar czf $SNAP_DIR/frontend-src.tar.gz frontend/src
cp frontend/src/api/projects.js $SNAP_DIR/projects.js.online
cp frontend/src/views/projects/ProjectDetail.vue $SNAP_DIR/ProjectDetail.vue.online
echo "SNAP_DIR=$SNAP_DIR"

echo ---B.replace_projects_js---
base64 -d /tmp/projects.js.b64 > frontend/src/api/projects.js
echo "projects.js md5=$(md5sum frontend/src/api/projects.js | cut -d' ' -f1)"

echo ---C.replace_ProjectDetail_vue---
base64 -d /tmp/ProjectDetail.vue.b64 > frontend/src/views/projects/ProjectDetail.vue
echo "ProjectDetail.vue md5=$(md5sum frontend/src/views/projects/ProjectDetail.vue | cut -d' ' -f1)"

echo ---D.build---
sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build nginx 2>&1 | tail -15

echo ---E.up---
sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d nginx 2>&1 | tail -8

echo ---F.ps---
sleep 6
sudo docker ps --format 'table {{.Names}}{{.Status}}{{.Ports}}' | grep -E "nginx|backend"
echo "DONE $TS"
echo ---END---
REMOTE_EOF

bash /tmp/deployfe.sh; echo MARKER_END_DFE
exit
cat > /tmp/verifyfe.sh << 'REMOTE_EOF'
echo ---A.http---
curl -sk -o /dev/null -w 'admin=%{http_code}\n' https://admin.gush.cdgushai.com/

echo ---B.index_bundle---
INDEX=$(curl -sk https://admin.gush.cdgushai.com/ | grep -oE 'assets/index-[A-Za-z0-9_-]+\.js' | head -1)
echo "INDEX=$INDEX"

echo ---C.ProjectDetail_chunk_grep---
for f in $(sudo docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | grep -E "ProjectDetail-[A-Za-z0-9_-]+\.js"); do
  echo "---$f---"
  sudo docker exec gush2-nginx cat "/usr/share/nginx/html/assets/$f" | grep -c "批量删除" || true
  sudo docker exec gush2-nginx cat "/usr/share/nginx/html/assets/$f" | grep -c "删除" | head -1
  sudo docker exec gush2-nginx cat "/usr/share/nginx/html/assets/$f" | grep -c "doDeleteCode\|batchDeleteCodes\|deleteRedeemCode" | head -1
done

echo ---END---
REMOTE_EOF

bash /tmp/verifyfe.sh; echo MARKER_END_VFE
exit
cat > /tmp/verifyfe2.sh << 'REMOTE_EOF'
echo ---A.ProjectDetail_chunk_detail---
sudo docker exec gush2-nginx sh -c '
cd /usr/share/nginx/html/assets
F="ProjectDetail-CALJaibU.js"
echo "size=$(stat -c %s $F)"
for kw in "批量删除" "删除" "作废" "已删除" "批量生成" "选择" "selection-change"; do
  c=$(cat $F | grep -o "$kw" | wc -l)
  echo "$kw = $c"
done
'
echo ---B.projects_api_chunk---
for f in $(sudo docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | grep -E "^(projects|api)-" 2>/dev/null); do
  echo "---$f---"
  sudo docker exec gush2-nginx cat "/usr/share/nginx/html/assets/$f" | grep -c "deleteRedeemCode" || true
done
echo ---END---
REMOTE_EOF

bash /tmp/verifyfe2.sh; echo MARKER_END_VFE2
cat > /tmp/vfe3.sh << 'REMOTE_EOF'
sudo docker exec gush2-nginx sh -c '
cd /usr/share/nginx/html/assets
echo "---list api chunks---"
ls api-*.js
echo "---grep codes url---"
for f in api-*.js; do
  echo "===$f==="
  # 抓 DELETE 调用 URL 模板（axois delete 模板字符串会带 \u 转义成 /projects/codes/${id}/）
  grep -oE "/projects/codes[^,\"`]{0,30}" "$f" | sort -u
done
'
echo ---END---
REMOTE_EOF

bash /tmp/vfe3.sh; echo MARKER_END_VFE3
cat > /tmp/vfe4.sh << 'REMOTE_EOF'
sudo docker exec gush2-nginx sh -c '
cd /usr/share/nginx/html/assets
for f in *.js; do
  c=$(grep -c "projects/codes" "$f" 2>/dev/null)
  if [ "$c" != "0" ]; then
    echo "$f codes_ref=$c"
  fi
done
echo ---all_chunks_with_codes---
for f in $(ls *.js); do
  c=$(grep -oE "/projects/codes[^\"\\\\]{0,40}" "$f" 2>/dev/null | sort -u | head -5)
  if [ -n "$c" ]; then
    echo "===$f==="
    echo "$c"
  fi
done
'
echo ---END---
REMOTE_EOF

bash /tmp/vfe4.sh; echo MARKER_END_VFE4
cat > /tmp/server_tar.sh << 'REMOTE_EOF'
set -e
cd /opt/gush2
TS=$(date +%Y%m%d-%H%M%S)
SNAP=/home/ubuntu/gush2-snapshots/gush2-full-code-${TS}.tar.gz
mkdir -p /home/ubuntu/gush2-snapshots
echo "TS=$TS SNAP=$SNAP"

# 排除 node_modules / .git / __pycache__ / dist / .env.local 等
tar czf "$SNAP" \
  --exclude=node_modules \
  --exclude=.git \
  --exclude=__pycache__ \
  --exclude='*.pyc' \
  --exclude='*.pyo' \
  --exclude='dist' \
  --exclude='.vite' \
  --exclude='.cache' \
  --exclude='*.log' \
  --exclude='.env.local' \
  .

SIZE=$(stat -c %s "$SNAP")
MD5=$(md5sum "$SNAP" | cut -d' ' -f1)
echo "GZIP_SIZE=$SIZE MD5=$MD5"

# base64 编码（每个 base64 字符 6 bit，估算 4/3 倍）
B64=$SNAP.b64
base64 "$SNAP" > "$B64"
B64_SIZE=$(stat -c %s "$B64")
B64_MD5=$(md5sum "$B64" | cut -d' ' -f1)
echo "B64_SIZE=$B64_SIZE B64_MD5=$B64_MD5 B64_PATH=$B64"

echo "DONE"
echo ---FILE COUNT---
tar tzf "$SNAP" | wc -l
echo ---TOP 20---
tar tzf "$SNAP" | head -20
REMOTE_EOF

bash /tmp/server_tar.sh; echo MARKER_END_TAR
exit
cat > /tmp/server_b64.txt << 'B64EOF'
cat /home/ubuntu/gush2-snapshots/gush2-full-code-20260603-080107.tar.gz.b64
base64 /home/ubuntu/gush2-snapshots/gush2-full-code-20260603-080107.tar.gz
cat > /tmp/ProjectLeads.vue.b64 << 'B64EOF'
PHRlbXBsYXRlPgogIDxkaXYgdi1sb2FkaW5nPSJsb2FkaW5nIiBjbGFzcz0ibGVhZHMiPgogICAgPCEtLSDpobbmoI8gLS0+CiAgICA8ZWwtY2FyZCBzaGFkb3c9Im5ldmVyIiBjbGFzcz0iaGRyLWNhcmQiPgogICAgICA8ZGl2IGNsYXNzPSJoZHIiPgogICAgICAgIDxlbC1idXR0b24gOmljb249IkFycm93TGVmdCIgbGluayBAY2xpY2s9IiRyb3V0ZXIucHVzaChgL3Byb2plY3RzLyR7cHJvamVjdElkfWApIj7ov5Tlm57pobnnm648L2VsLWJ1dHRvbj4KICAgICAgICA8c3BhbiBjbGFzcz0idGl0bGUiPnt7IHByb2plY3ROYW1lIH19IMK3IOeUqOaIt+iOt+Wuojwvc3Bhbj4KICAgICAgICA8ZGl2IGNsYXNzPSJzcGFjZXIiIC8+CiAgICAgICAgPGVsLWJ1dHRvbiA6aWNvbj0iRG93bmxvYWQiIEBjbGljaz0iZG9FeHBvcnQiPuWvvOWHuiBDU1Y8L2VsLWJ1dHRvbj4KICAgICAgICA8ZWwtYnV0dG9uIDppY29uPSJSZWZyZXNoIiBAY2xpY2s9InJlbG9hZCI+5Yi35pawPC9lbC1idXR0b24+CiAgICAgIDwvZGl2PgogICAgPC9lbC1jYXJkPgoKICAgIDwhLS0gS1BJIOeUu+WDj+axh+aAuyAtLT4KICAgIDxkaXYgY2xhc3M9ImtwaS1yb3ciPgogICAgICA8ZGl2IGNsYXNzPSJrcGktY2FyZCI+CiAgICAgICAgPGRpdiBjbGFzcz0ia3BpLWxhYmVsIj7mgLvkurrohLjop4LmtYs8L2Rpdj4KICAgICAgICA8ZGl2IGNsYXNzPSJrcGktdmFsdWUiPnt7IHN1bW1hcnk/LnRvdGFsX2ZhY2VzID8/IDAgfX08L2Rpdj4KICAgICAgICA8ZGl2IGNsYXNzPSJrcGktc3ViIj7lt7LpoobnoIEge3sgc3VtbWFyeT8uY2xhaW1lZF9mYWNlcyA/PyAwIH19PC9kaXY+CiAgICAgIDwvZGl2PgogICAgICA8ZGl2IGNsYXNzPSJrcGktY2FyZCBzdWNjZXNzIj4KICAgICAgICA8ZGl2IGNsYXNzPSJrcGktbGFiZWwiPuW+rueskeeOhzwvZGl2PgogICAgICAgIDxkaXYgY2xhc3M9ImtwaS12YWx1ZSI+e3sgc3VtbWFyeT8uc21pbGVfcmF0aW8gPz8gMCB9fSU8L2Rpdj4KICAgICAgICA8ZGl2IGNsYXNzPSJrcGktc3ViIj57eyBzdW1tYXJ5Py5zbWlsZV9jb3VudCA/PyAwIH19IOW8oOW+rueskTwvZGl2PgogICAgICA8L2Rpdj4KICAgICAgPGRpdiBjbGFzcz0ia3BpLWNhcmQgY2hhcnQtY2FyZCI+CiAgICAgICAgPGRpdiBjbGFzcz0ia3BpLWxhYmVsIj7mgKfliKvliIbluIM8L2Rpdj4KICAgICAgICA8ZGl2IHJlZj0iZ2VuZGVyQ2hhcnRFbCIgY2xhc3M9ImtwaS1jaGFydCIgLz4KICAgICAgPC9kaXY+CiAgICAgIDxkaXYgY2xhc3M9ImtwaS1jYXJkIGNoYXJ0LWNhcmQiPgogICAgICAgIDxkaXYgY2xhc3M9ImtwaS1sYWJlbCI+5bm06b6E5q615YiG5biDPC9kaXY+CiAgICAgICAgPGRpdiByZWY9ImFnZUNoYXJ0RWwiIGNsYXNzPSJrcGktY2hhcnQiIC8+CiAgICAgIDwvZGl2PgogICAgICA8ZGl2IGNsYXNzPSJrcGktY2FyZCBjaGFydC1jYXJkIj4KICAgICAgICA8ZGl2IGNsYXNzPSJrcGktbGFiZWwiPuaDhee7quWIhuW4gzwvZGl2PgogICAgICAgIDxkaXYgcmVmPSJlbW90aW9uQ2hhcnRFbCIgY2xhc3M9ImtwaS1jaGFydCIgLz4KICAgICAgPC9kaXY+CiAgICA8L2Rpdj4KCiAgICA8IS0tIOetm+mAiSArIOihqOagvCAtLT4KICAgIDxlbC1jYXJkIHNoYWRvdz0ibmV2ZXIiIGNsYXNzPSJmaWx0ZXItY2FyZCI+CiAgICAgIDxkaXYgY2xhc3M9ImZpbHRlci1yb3ciPgogICAgICAgIDxlbC1pbnB1dCB2LW1vZGVsPSJmaWx0ZXJzLnNlYXJjaCIgcGxhY2Vob2xkZXI9IuaQnOe0oiDnp7DlkbwgLyDlhZHmjaLnoIEiCiAgICAgICAgICAgICAgICAgIHN0eWxlPSJ3aWR0aDoyMDBweCIgY2xlYXJhYmxlIEBrZXl1cC5lbnRlcj0icmVsb2FkIiAvPgogICAgICAgIDxlbC1zZWxlY3Qgdi1tb2RlbD0iZmlsdGVycy5zdGF0dXMiIHBsYWNlaG9sZGVyPSLnirbmgIEiIGNsZWFyYWJsZSBzdHlsZT0id2lkdGg6MTIwcHgiIEBjaGFuZ2U9InJlbG9hZCI+CiAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLmnKrkvb/nlKgiIHZhbHVlPSJ1bnVzZWQiIC8+CiAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlt7Lkvb/nlKgiIHZhbHVlPSJ1c2VkIiAvPgogICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5bey6L+H5pyfIiB2YWx1ZT0iZXhwaXJlZCIgLz4KICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuW3suS9nOW6nyIgdmFsdWU9InJldm9rZWQiIC8+CiAgICAgICAgPC9lbC1zZWxlY3Q+CiAgICAgICAgPGVsLXNlbGVjdCB2LW1vZGVsPSJmaWx0ZXJzLmdlbmRlciIgcGxhY2Vob2xkZXI9IuaAp+WIqyIgY2xlYXJhYmxlIHN0eWxlPSJ3aWR0aDoxMDBweCIgQGNoYW5nZT0icmVsb2FkIj4KICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IueUtyIgdmFsdWU9Im1hbGUiIC8+CiAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlpbMiIHZhbHVlPSJmZW1hbGUiIC8+CiAgICAgICAgPC9lbC1zZWxlY3Q+CiAgICAgICAgPGVsLXNlbGVjdCB2LW1vZGVsPSJmaWx0ZXJzLmFnZV9yYW5nZSIgcGxhY2Vob2xkZXI9IuW5tOm+hOautSIgY2xlYXJhYmxlIHN0eWxlPSJ3aWR0aDoxNDBweCIgQGNoYW5nZT0icmVsb2FkIj4KICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IuWEv+erpSIgdmFsdWU9ImNoaWxkIiAvPgogICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i6Z2S5bCR5bm0IiB2YWx1ZT0idGVlbiIgLz4KICAgICAgICAgIDxlbC1vcHRpb24gbGFiZWw9IumdkuW5tCAoMTgtMzApIiB2YWx1ZT0ieW91bmdfYWR1bHQiIC8+CiAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLkuK3lubQgKDMxLTUwKSIgdmFsdWU9ImFkdWx0IiAvPgogICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5Lit6ICB5bm0ICg1MSspIiB2YWx1ZT0ic2VuaW9yIiAvPgogICAgICAgIDwvZWwtc2VsZWN0PgogICAgICAgIDxlbC1zZWxlY3Qgdi1tb2RlbD0iZmlsdGVycy5lbW90aW9uIiBwbGFjZWhvbGRlcj0i5oOF57uqIiBjbGVhcmFibGUgc3R5bGU9IndpZHRoOjEyMHB4IiBAY2hhbmdlPSJyZWxvYWQiPgogICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5byA5b+DIiB2YWx1ZT0iaGFwcHkiIC8+CiAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlubPpnZkiIHZhbHVlPSJuZXV0cmFsIiAvPgogICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5oOK6K62IiB2YWx1ZT0ic3VycHJpc2VkIiAvPgogICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i5oKy5LykIiB2YWx1ZT0ic2FkIiAvPgogICAgICAgICAgPGVsLW9wdGlvbiBsYWJlbD0i55Sf5rCUIiB2YWx1ZT0iYW5ncnkiIC8+CiAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLljozmgbYiIHZhbHVlPSJkaXNndXN0ZWQiIC8+CiAgICAgICAgICA8ZWwtb3B0aW9uIGxhYmVsPSLlrrPmgJUiIHZhbHVlPSJmZWFyIiAvPgogICAgICAgIDwvZWwtc2VsZWN0PgogICAgICAgIDxlbC1idXR0b24gOmljb249IlNlYXJjaCIgdHlwZT0icHJpbWFyeSIgQGNsaWNrPSJyZWxvYWQiPuafpeivojwvZWwtYnV0dG9uPgogICAgICAgIDxlbC1idXR0b24gOmljb249IlJlZnJlc2hMZWZ0IiBAY2xpY2s9InJlc2V0RmlsdGVycyI+6YeN572uPC9lbC1idXR0b24+CiAgICAgIDwvZGl2PgogICAgPC9lbC1jYXJkPgoKICAgIDwhLS0g6KGo5qC8IC0tPgogICAgPGVsLWNhcmQgc2hhZG93PSJuZXZlciI+CiAgICAgIDxlbC10YWJsZSA6ZGF0YT0icm93cyIgc3RyaXBlIHNpemU9InNtYWxsIiBlbXB0eS10ZXh0PSLmmoLml6DmlbDmja4iPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gbGFiZWw9IumihuWPluaXtumXtCIgd2lkdGg9IjE1MCI+CiAgICAgICAgICA8dGVtcGxhdGUgI2RlZmF1bHQ9Insgcm93IH0iPnt7IGZvcm1hdFRpbWUocm93LmNsYWltZWRfYXQpIH19PC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLXRhYmxlLWNvbHVtbj4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIHByb3A9InVzZXJfbmlja25hbWUiIGxhYmVsPSLlp5PlkI0iIHdpZHRoPSIxMDAiPgogICAgICAgICAgPHRlbXBsYXRlICNkZWZhdWx0PSJ7IHJvdyB9Ij57eyByb3cudXNlcl9uaWNrbmFtZSB8fCAn4oCUJyB9fTwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC10YWJsZS1jb2x1bW4+CiAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiB2LWZvcj0iZmllbGQgaW4gZm9ybUZpZWxkcyIgOmtleT0iZmllbGQua2V5IiA6bGFiZWw9ImZpZWxkLmxhYmVsIiA6bWluLXdpZHRoPSJmaWVsZC50eXBlID09PSAnbXVsdGlzZWxlY3QnID8gMTgwIDogMTIwIj4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD0ieyByb3cgfSI+e3sgZm9ybWF0Rm9ybVZhbHVlKHJvdy5mb3JtX2RhdGE/LltmaWVsZC5rZXldKSB9fTwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC10YWJsZS1jb2x1bW4+CiAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBsYWJlbD0i5YWR5o2i56CBIiB3aWR0aD0iMTAwIj4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD0ieyByb3cgfSI+PHNwYW4gY2xhc3M9ImNvZGUtY2VsbCI+e3sgcm93LmNvZGUgfX08L3NwYW4+PC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLXRhYmxlLWNvbHVtbj4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIGxhYmVsPSLnirbmgIEiIHdpZHRoPSI5MCI+CiAgICAgICAgICA8dGVtcGxhdGUgI2RlZmF1bHQ9Insgcm93IH0iPgogICAgICAgICAgICA8ZWwtdGFnIHNpemU9InNtYWxsIiA6dHlwZT0ic3RhdHVzVGFnKHJvdy5zdGF0dXMpIj57eyByb3cuc3RhdHVzX2xhYmVsIH19PC9lbC10YWc+CiAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgIDwvZWwtdGFibGUtY29sdW1uPgoKICAgICAgICA8IS0tIOeUu+WDj+WIlyAtLT4KICAgICAgICA8ZWwtdGFibGUtY29sdW1uIGxhYmVsPSLnlLvlg4/vvIjmkYTlg4/lpLTvvIkiIG1pbi13aWR0aD0iMjgwIj4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD0ieyByb3cgfSI+CiAgICAgICAgICAgIDx0ZW1wbGF0ZSB2LWlmPSJyb3cuZmFjZSI+CiAgICAgICAgICAgICAgPGVsLXRhZyBzaXplPSJzbWFsbCIgOnR5cGU9InJvdy5mYWNlLmdlbmRlciA9PT0gJ2ZlbWFsZScgPyAnZGFuZ2VyJyA6ICdwcmltYXJ5JyIgZWZmZWN0PSJwbGFpbiI+CiAgICAgICAgICAgICAgICB7eyByb3cuZmFjZS5nZW5kZXJfbGFiZWwgfX0KICAgICAgICAgICAgICA8L2VsLXRhZz4KICAgICAgICAgICAgICA8ZWwtdGFnIHNpemU9InNtYWxsIiB0eXBlPSJpbmZvIiBlZmZlY3Q9InBsYWluIiBzdHlsZT0ibWFyZ2luLWxlZnQ6NnB4Ij4KICAgICAgICAgICAgICAgIHt7IHJvdy5mYWNlLmFnZSB8fCAnPycgfX0g5bKBIMK3IHt7IHJvdy5mYWNlLmFnZV9yYW5nZV9sYWJlbCB9fQogICAgICAgICAgICAgIDwvZWwtdGFnPgogICAgICAgICAgICAgIDxlbC10YWcgc2l6ZT0ic21hbGwiIHR5cGU9Indhcm5pbmciIGVmZmVjdD0icGxhaW4iIHN0eWxlPSJtYXJnaW4tbGVmdDo2cHgiPgogICAgICAgICAgICAgICAge3sgZW1vdGlvbkljb24ocm93LmZhY2UuZG9taW5hbnRfZW1vdGlvbikgfX0ge3sgcm93LmZhY2UuZG9taW5hbnRfZW1vdGlvbl9sYWJlbCB9fQogICAgICAgICAgICAgIDwvZWwtdGFnPgogICAgICAgICAgICAgIDxlbC10YWcgdi1pZj0icm93LmZhY2UuaXNfc21pbGluZyIgc2l6ZT0ic21hbGwiIHR5cGU9InN1Y2Nlc3MiIGVmZmVjdD0iZGFyayIgc3R5bGU9Im1hcmdpbi1sZWZ0OjZweCI+CiAgICAgICAgICAgICAgICDwn5iKIOW+rueskQogICAgICAgICAgICAgIDwvZWwtdGFnPgogICAgICAgICAgICA8L3RlbXBsYXRlPgogICAgICAgICAgICA8c3BhbiB2LWVsc2Ugc3R5bGU9ImNvbG9yOiB2YXIoLS1lbC10ZXh0LWNvbG9yLXNlY29uZGFyeSk7IGZvbnQtc2l6ZTogMTJweCI+4oCUIOaXoOingua1izwvc3Bhbj4KICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC10YWJsZS1jb2x1bW4+CgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gbGFiZWw9IuiuvuWkhyIgd2lkdGg9IjEzMCI+CiAgICAgICAgICA8dGVtcGxhdGUgI2RlZmF1bHQ9Insgcm93IH0iPgogICAgICAgICAgICA8ZGl2IHN0eWxlPSJmb250LXNpemU6MTJweCI+CiAgICAgICAgICAgICAgPGRpdiB2LWlmPSJyb3cuY2xhaW1fbWFjaGluZV9pZCI+5omr56CBOiB7eyByb3cuY2xhaW1fbWFjaGluZV9pZCB9fTwvZGl2PgogICAgICAgICAgICAgIDxkaXYgdi1pZj0icm93LnVzZWRfbWFjaGluZV9pZCI+5qC46ZSAOiB7eyByb3cudXNlZF9tYWNoaW5lX2lkIH19IC8ge3sgcm93LnVzZWRfY2hhbm5lbCB9fTwvZGl2PgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDwvdGVtcGxhdGU+CiAgICAgICAgPC9lbC10YWJsZS1jb2x1bW4+CiAgICAgICAgPGVsLXRhYmxlLWNvbHVtbiBsYWJlbD0i5qC46ZSA5pe26Ze0IiB3aWR0aD0iMTUwIj4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD0ieyByb3cgfSI+e3sgZm9ybWF0VGltZShyb3cudXNlZF9hdCkgfHwgJ+KAlCcgfX08L3RlbXBsYXRlPgogICAgICAgIDwvZWwtdGFibGUtY29sdW1uPgogICAgICAgIDxlbC10YWJsZS1jb2x1bW4gbGFiZWw9IuaTjeS9nCIgd2lkdGg9IjEyMCIgZml4ZWQ9InJpZ2h0Ij4KICAgICAgICAgIDx0ZW1wbGF0ZSAjZGVmYXVsdD4KICAgICAgICAgICAgPHNwYW4gc3R5bGU9ImNvbG9yOiB2YXIoLS1lbC10ZXh0LWNvbG9yLXNlY29uZGFyeSk7IGZvbnQtc2l6ZTogMTJweCI+4oCUPC9zcGFuPgogICAgICAgICAgPC90ZW1wbGF0ZT4KICAgICAgICA8L2VsLXRhYmxlLWNvbHVtbj4KICAgICAgPC9lbC10YWJsZT4KCiAgICAgIDxlbC1wYWdpbmF0aW9uCiAgICAgICAgdi1tb2RlbDpjdXJyZW50LXBhZ2U9InBhZ2UuY3VycmVudCIKICAgICAgICB2LW1vZGVsOnBhZ2Utc2l6ZT0icGFnZS5zaXplIgogICAgICAgIDp0b3RhbD0icGFnZS50b3RhbCIKICAgICAgICA6cGFnZS1zaXplcz0iWzIwLCAzMCwgNTAsIDEwMF0iCiAgICAgICAgbGF5b3V0PSJ0b3RhbCwgc2l6ZXMsIHByZXYsIHBhZ2VyLCBuZXh0IgogICAgICAgIEBjdXJyZW50LWNoYW5nZT0ibG9hZExpc3QiCiAgICAgICAgQHNpemUtY2hhbmdlPSJsb2FkTGlzdCIKICAgICAgICBzdHlsZT0ibWFyZ2luLXRvcDoxNHB4OyBqdXN0aWZ5LWNvbnRlbnQ6IGZsZXgtZW5kIgogICAgICAvPgogICAgPC9lbC1jYXJkPgogIDwvZGl2Pgo8L3RlbXBsYXRlPgoKPHNjcmlwdCBzZXR1cD4KaW1wb3J0IHsgcmVmLCByZWFjdGl2ZSwgb25Nb3VudGVkLCBvblVubW91bnRlZCwgbmV4dFRpY2sgfSBmcm9tICd2dWUnCmltcG9ydCB7IHVzZVJvdXRlIH0gZnJvbSAndnVlLXJvdXRlcicKaW1wb3J0IHsgRWxNZXNzYWdlIH0gZnJvbSAnZWxlbWVudC1wbHVzJwppbXBvcnQgewogIEFycm93TGVmdCwgRG93bmxvYWQsIFJlZnJlc2gsIFJlZnJlc2hMZWZ0LCBTZWFyY2gKfSBmcm9tICdAZWxlbWVudC1wbHVzL2ljb25zLXZ1ZScKaW1wb3J0ICogYXMgZWNoYXJ0cyBmcm9tICdlY2hhcnRzJwppbXBvcnQgeyBnZXRQcm9qZWN0IH0gZnJvbSAnQC9hcGkvcHJvamVjdHMnCmltcG9ydCB7IGdldFByb2plY3RINSB9IGZyb20gJ0AvYXBpL3BhZ2VzJwppbXBvcnQgeyBsaXN0TGVhZHMsIGxlYWRzU3VtbWFyeSwgZXhwb3J0TGVhZHNDc3YgfSBmcm9tICdAL2FwaS9sZWFkcycKCmNvbnN0IHJvdXRlID0gdXNlUm91dGUoKQpjb25zdCBwcm9qZWN0SWQgPSBOdW1iZXIocm91dGUucGFyYW1zLmlkKQpjb25zdCBwcm9qZWN0TmFtZSA9IHJlZignJykKCmNvbnN0IGxvYWRpbmcgPSByZWYoZmFsc2UpCmNvbnN0IHJvd3MgPSByZWYoW10pCmNvbnN0IHN1bW1hcnkgPSByZWYobnVsbCkKY29uc3QgZm9ybUZpZWxkcyA9IHJlZihbXSkKY29uc3QgcGFnZSA9IHJlYWN0aXZlKHsgY3VycmVudDogMSwgc2l6ZTogMzAsIHRvdGFsOiAwIH0pCmNvbnN0IGZpbHRlcnMgPSByZWFjdGl2ZSh7CiAgc2VhcmNoOiAnJywgc3RhdHVzOiAnJywgZ2VuZGVyOiAnJywgYWdlX3JhbmdlOiAnJywgZW1vdGlvbjogJycKfSkKCmNvbnN0IGdlbmRlckNoYXJ0RWwgPSByZWYobnVsbCkKY29uc3QgYWdlQ2hhcnRFbCA9IHJlZihudWxsKQpjb25zdCBlbW90aW9uQ2hhcnRFbCA9IHJlZihudWxsKQpsZXQgZ2VuZGVyQ2hhcnQgPSBudWxsCmxldCBhZ2VDaGFydCA9IG51bGwKbGV0IGVtb3Rpb25DaGFydCA9IG51bGwKCmNvbnN0IFNUQVRVU19UQUdTID0geyB1bnVzZWQ6ICdzdWNjZXNzJywgdXNlZDogJ2luZm8nLCBleHBpcmVkOiAnd2FybmluZycsIHJldm9rZWQ6ICdkYW5nZXInIH0KZnVuY3Rpb24gc3RhdHVzVGFnKHMpIHsgcmV0dXJuIFNUQVRVU19UQUdTW3NdIHx8ICcnIH0KCmNvbnN0IEVNT1RJT05fSUNPTlMgPSB7CiAgaGFwcHk6ICfwn5iEJywgbmV1dHJhbDogJ/CfmJAnLCBzdXJwcmlzZWQ6ICfwn5iyJywgc2FkOiAn8J+YoicsCiAgYW5ncnk6ICfwn5igJywgZGlzZ3VzdGVkOiAn8J+koicsIGZlYXI6ICfwn5ioJwp9CmZ1bmN0aW9uIGVtb3Rpb25JY29uKGUpIHsgcmV0dXJuIEVNT1RJT05fSUNPTlNbZV0gfHwgJz8nIH0KCmZ1bmN0aW9uIGZvcm1hdFRpbWUocykgewogIGlmICghcykgcmV0dXJuICcnCiAgcmV0dXJuIG5ldyBEYXRlKHMpLnRvTG9jYWxlU3RyaW5nKCd6aC1DTicsIHsgaG91cjEyOiBmYWxzZSB9KS5yZXBsYWNlKC9cLy9nLCAnLScpCn0KCmZ1bmN0aW9uIGZvcm1hdEZvcm1WYWx1ZSh2YWwpIHsKICBpZiAodmFsID09PSBudWxsIHx8IHZhbCA9PT0gdW5kZWZpbmVkIHx8IHZhbCA9PT0gJycpIHJldHVybiAn4oCUJwogIGlmIChBcnJheS5pc0FycmF5KHZhbCkpIHsKICAgIGlmICh2YWwubGVuZ3RoID09PSAwKSByZXR1cm4gJ+KAlCcKICAgIHJldHVybiB2YWwuam9pbign44CBJykKICB9CiAgcmV0dXJuIFN0cmluZyh2YWwpCn0KCmZ1bmN0aW9uIHJlc2V0RmlsdGVycygpIHsKICBPYmplY3QuYXNzaWduKGZpbHRlcnMsIHsgc2VhcmNoOiAnJywgc3RhdHVzOiAnJywgZ2VuZGVyOiAnJywgYWdlX3JhbmdlOiAnJywgZW1vdGlvbjogJycgfSkKICByZWxvYWQoKQp9Cgpjb25zdCBHRU5ERVJfTEFCRUxTID0geyBtYWxlOiAn55S3JywgZmVtYWxlOiAn5aWzJywgdW5rbm93bjogJ+acquefpScgfQpjb25zdCBBR0VfTEFCRUxTID0gewogIGNoaWxkOiAn5YS/56ulJywgdGVlbjogJ+mdkuWwkeW5tCcsIHlvdW5nX2FkdWx0OiAn6Z2S5bm0JywKICBhZHVsdDogJ+S4reW5tCcsIHNlbmlvcjogJ+S4reiAgeW5tCcsIHVua25vd246ICfmnKrnn6UnLAp9CmNvbnN0IEVNT19MQUJFTFMgPSB7CiAgaGFwcHk6ICflvIDlv4MnLCBuZXV0cmFsOiAn5bmz6Z2ZJywgc3VycHJpc2VkOiAn5oOK6K62Jywgc2FkOiAn5oKy5LykJywKICBhbmdyeTogJ+eUn+awlCcsIGRpc2d1c3RlZDogJ+WOjOaBticsIGZlYXI6ICflrrPmgJUnLCB1bmtub3duOiAn5pyq55+lJywKfQoKZnVuY3Rpb24gcmVuZGVyUGllKGNoYXJ0UmVmLCBkYXRhT2JqLCBsYWJlbE1hcCwgcGFsZXR0ZSkgewogIGlmICghY2hhcnRSZWYudmFsdWUpIHJldHVybiBudWxsCiAgY29uc3QgY2hhcnQgPSBlY2hhcnRzLmluaXQoY2hhcnRSZWYudmFsdWUpCiAgY29uc3QgZGF0YSA9IE9iamVjdC5lbnRyaWVzKGRhdGFPYmogfHwge30pLm1hcCgoW2ssIHZdKSA9PiAoewogICAgdmFsdWU6IHYsIG5hbWU6IGxhYmVsTWFwW2tdIHx8IGsKICB9KSkKICBjaGFydC5zZXRPcHRpb24oewogICAgdG9vbHRpcDogeyB0cmlnZ2VyOiAnaXRlbScsIGZvcm1hdHRlcjogJ3tifToge2N9ICh7ZH0lKScgfSwKICAgIGNvbG9yOiBwYWxldHRlLAogICAgc2VyaWVzOiBbewogICAgICB0eXBlOiAncGllJywKICAgICAgcmFkaXVzOiBbJzQwJScsICc3MCUnXSwKICAgICAgY2VudGVyOiBbJzUwJScsICc1NSUnXSwKICAgICAgbGFiZWw6IHsgZm9udFNpemU6IDExIH0sCiAgICAgIGRhdGEsCiAgICB9XQogIH0sIHRydWUpCiAgcmV0dXJuIGNoYXJ0Cn0KCmFzeW5jIGZ1bmN0aW9uIGxvYWRTdW1tYXJ5KCkgewogIHN1bW1hcnkudmFsdWUgPSBhd2FpdCBsZWFkc1N1bW1hcnkocHJvamVjdElkKQogIGF3YWl0IG5leHRUaWNrKCkKICBnZW5kZXJDaGFydD8uZGlzcG9zZSgpCiAgYWdlQ2hhcnQ/LmRpc3Bvc2UoKQogIGVtb3Rpb25DaGFydD8uZGlzcG9zZSgpCiAgZ2VuZGVyQ2hhcnQgPSByZW5kZXJQaWUoZ2VuZGVyQ2hhcnRFbCwgc3VtbWFyeS52YWx1ZS5ieV9nZW5kZXIsIEdFTkRFUl9MQUJFTFMsCiAgICBbJyM0MDllZmYnLCAnI2Y1NmM2YycsICcjOTA5Mzk5J10pCiAgYWdlQ2hhcnQgPSByZW5kZXJQaWUoYWdlQ2hhcnRFbCwgc3VtbWFyeS52YWx1ZS5ieV9hZ2VfcmFuZ2UsIEFHRV9MQUJFTFMsCiAgICBbJyNhMGNmZmYnLCAnIzY3YzIzYScsICcjZTZhMjNjJywgJyNmNTZjNmMnLCAnIzkwOTM5OSddKQogIGVtb3Rpb25DaGFydCA9IHJlbmRlclBpZShlbW90aW9uQ2hhcnRFbCwgc3VtbWFyeS52YWx1ZS5ieV9lbW90aW9uLCBFTU9fTEFCRUxTLAogICAgWycjNjdjMjNhJywgJyM5MDkzOTknLCAnI2U2YTIzYycsICcjYTBjZmZmJywgJyNmNTZjNmMnLCAnIzliNTliNicsICcjMzQ0OTVlJ10pCn0KCmFzeW5jIGZ1bmN0aW9uIGxvYWRMaXN0KCkgewogIGxvYWRpbmcudmFsdWUgPSB0cnVlCiAgdHJ5IHsKICAgIGNvbnN0IHBhcmFtcyA9IHsKICAgICAgcGFnZTogcGFnZS5jdXJyZW50LCBwYWdlX3NpemU6IHBhZ2Uuc2l6ZSwKICAgIH0KICAgIGZvciAoY29uc3QgW2ssIHZdIG9mIE9iamVjdC5lbnRyaWVzKGZpbHRlcnMpKSB7CiAgICAgIGlmICh2KSBwYXJhbXNba10gPSB2CiAgICB9CiAgICBjb25zdCByZXNwID0gYXdhaXQgbGlzdExlYWRzKHByb2plY3RJZCwgcGFyYW1zKQogICAgcm93cy52YWx1ZSA9IHJlc3AucmVzdWx0cwogICAgcGFnZS50b3RhbCA9IHJlc3AuY291bnQKICB9IGZpbmFsbHkgewogICAgbG9hZGluZy52YWx1ZSA9IGZhbHNlCiAgfQp9Cgphc3luYyBmdW5jdGlvbiByZWxvYWQoKSB7CiAgcGFnZS5jdXJyZW50ID0gMQogIGF3YWl0IFByb21pc2UuYWxsKFtsb2FkU3VtbWFyeSgpLCBsb2FkTGlzdCgpXSkKfQoKYXN5bmMgZnVuY3Rpb24gZG9FeHBvcnQoKSB7CiAgdHJ5IHsKICAgIGNvbnN0IHBhcmFtcyA9IHt9CiAgICBmb3IgKGNvbnN0IFtrLCB2XSBvZiBPYmplY3QuZW50cmllcyhmaWx0ZXJzKSkgaWYgKHYpIHBhcmFtc1trXSA9IHYKICAgIGF3YWl0IGV4cG9ydExlYWRzQ3N2KHByb2plY3RJZCwgcGFyYW1zKQogICAgRWxNZXNzYWdlLnN1Y2Nlc3MoJ0NTViDlt7LkuIvovb0nKQogIH0gY2F0Y2ggKGUpIHsgLyogaHR0cCDmi6bmiKrlmajlt7LlvLnplJkgKi8gfQp9CgpmdW5jdGlvbiBvblJlc2l6ZSgpIHsKICBnZW5kZXJDaGFydD8ucmVzaXplKCkKICBhZ2VDaGFydD8ucmVzaXplKCkKICBlbW90aW9uQ2hhcnQ/LnJlc2l6ZSgpCn0KCm9uTW91bnRlZChhc3luYyAoKSA9PiB7CiAgY29uc3QgcCA9IGF3YWl0IGdldFByb2plY3QocHJvamVjdElkKQogIHByb2plY3ROYW1lLnZhbHVlID0gcC5uYW1lCiAgdHJ5IHsKICAgIGNvbnN0IGg1ID0gYXdhaXQgZ2V0UHJvamVjdEg1KHByb2plY3RJZCkKICAgIGZvcm1GaWVsZHMudmFsdWUgPSBoNS5mb3JtX2ZpZWxkcyB8fCBbXQogIH0gY2F0Y2ggeyAvKiBINSDpobXmnKrphY3nva7ml7bkuI3lvbHlk43liJfooaggKi8gfQogIGF3YWl0IHJlbG9hZCgpCiAgd2luZG93LmFkZEV2ZW50TGlzdGVuZXIoJ3Jlc2l6ZScsIG9uUmVzaXplKQp9KQpvblVubW91bnRlZCgoKSA9PiB7CiAgd2luZG93LnJlbW92ZUV2ZW50TGlzdGVuZXIoJ3Jlc2l6ZScsIG9uUmVzaXplKQogIGdlbmRlckNoYXJ0Py5kaXNwb3NlKCkKICBhZ2VDaGFydD8uZGlzcG9zZSgpCiAgZW1vdGlvbkNoYXJ0Py5kaXNwb3NlKCkKfSkKPC9zY3JpcHQ+Cgo8c3R5bGUgc2NvcGVkPgoubGVhZHMgeyBkaXNwbGF5OiBmbGV4OyBmbGV4LWRpcmVjdGlvbjogY29sdW1uOyBnYXA6IDE0cHg7IH0KCi5oZHItY2FyZCA6ZGVlcCguZWwtY2FyZF9fYm9keSkgeyBkaXNwbGF5OiBub25lOyB9Ci5oZHIgeyBkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogY2VudGVyOyBnYXA6IDEycHg7IHBhZGRpbmc6IDRweCAwOyB9Ci5oZHIgLnRpdGxlIHsgZm9udC1zaXplOiAxNnB4OyBmb250LXdlaWdodDogNjAwOyB9Ci5oZHIgLnNwYWNlciB7IGZsZXg6IDE7IH0KCi5rcGktcm93IHsKICBkaXNwbGF5OiBncmlkOwogIGdyaWQtdGVtcGxhdGUtY29sdW1uczogMWZyIDFmciAxLjVmciAxLjVmciAxLjVmcjsKICBnYXA6IDEycHg7Cn0KLmtwaS1jYXJkIHsKICBiYWNrZ3JvdW5kOiB2YXIoLS1lbC1iZy1jb2xvcik7CiAgYm9yZGVyOiAxcHggc29saWQgdmFyKC0tZWwtYm9yZGVyLWNvbG9yLWxpZ2h0KTsKICBib3JkZXItcmFkaXVzOiAxMHB4OwogIHBhZGRpbmc6IDE0cHggMTZweDsKICBtaW4taGVpZ2h0OiAxMTBweDsKICBkaXNwbGF5OiBmbGV4OyBmbGV4LWRpcmVjdGlvbjogY29sdW1uOwp9Ci5rcGktY2FyZC5zdWNjZXNzIHsgYm9yZGVyLWxlZnQ6IDRweCBzb2xpZCB2YXIoLS1lbC1jb2xvci1zdWNjZXNzKTsgfQoua3BpLWNhcmQuY2hhcnQtY2FyZCB7IHBhZGRpbmc6IDEwcHggOHB4IDZweDsgfQoua3BpLWxhYmVsIHsgY29sb3I6IHZhcigtLWVsLXRleHQtY29sb3Itc2Vjb25kYXJ5KTsgZm9udC1zaXplOiAxM3B4OyB9Ci5rcGktdmFsdWUgeyBmb250LXNpemU6IDI4cHg7IGZvbnQtd2VpZ2h0OiA3MDA7IG1hcmdpbi10b3A6IDRweDsgbGluZS1oZWlnaHQ6IDEuMTsgY29sb3I6IHZhcigtLWVsLXRleHQtY29sb3ItcHJpbWFyeSk7IH0KLmtwaS1zdWIgeyBjb2xvcjogdmFyKC0tZWwtdGV4dC1jb2xvci1zZWNvbmRhcnkpOyBmb250LXNpemU6IDEycHg7IG1hcmdpbi10b3A6IDZweDsgfQoua3BpLWNoYXJ0IHsgZmxleDogMTsgbWluLWhlaWdodDogOTBweDsgfQoKLmZpbHRlci1jYXJkIDpkZWVwKC5lbC1jYXJkX19ib2R5KSB7IHBhZGRpbmc6IDE0cHggMThweDsgfQouZmlsdGVyLXJvdyB7IGRpc3BsYXk6IGZsZXg7IGZsZXgtd3JhcDogd3JhcDsgZ2FwOiAxMHB4OyBhbGlnbi1pdGVtczogY2VudGVyOyB9CgouY29kZS1jZWxsIHsKICBiYWNrZ3JvdW5kOiB2YXIoLS1lbC1maWxsLWNvbG9yLWxpZ2h0KTsKICBib3JkZXI6IDFweCBzb2xpZCB2YXIoLS1lbC1ib3JkZXItY29sb3ItbGlnaHRlcik7CiAgcGFkZGluZzogMXB4IDhweDsgYm9yZGVyLXJhZGl1czogNHB4OwogIGZvbnQtZmFtaWx5OiB1aS1tb25vc3BhY2UsIE1lbmxvLCBtb25vc3BhY2U7IGZvbnQtc2l6ZTogMTJweDsKfQouZm9ybS1kYXRhLWNlbGwgeyBkaXNwbGF5OiBmbGV4OyBmbGV4LWRpcmVjdGlvbjogY29sdW1uOyBnYXA6IDJweDsgfQouZm9ybS1kYXRhLWl0ZW0geyBmb250LXNpemU6IDEycHg7IGxpbmUtaGVpZ2h0OiAxLjQ7IH0KLmZvcm0ta2V5IHsgY29sb3I6IHZhcigtLWVsLXRleHQtY29sb3Itc2Vjb25kYXJ5KTsgbWFyZ2luLXJpZ2h0OiA0cHg7IH0KLmZvcm0tdmFsIHsgY29sb3I6IHZhcigtLWVsLXRleHQtY29sb3ItcHJpbWFyeSk7IH0KCkBtZWRpYSAobWF4LXdpZHRoOiAxMjAwcHgpIHsKICAua3BpLXJvdyB7IGdyaWQtdGVtcGxhdGUtY29sdW1uczogMWZyIDFmciAxZnI7IH0KICAua3BpLXJvdyA+IC5jaGFydC1jYXJkOm50aC1jaGlsZChuKzMpIHsgZ3JpZC1jb2x1bW46IHNwYW4gMTsgfQp9Cjwvc3R5bGU+Cg==
B64EOF

md5sum /tmp/ProjectLeads.vue.b64; echo MARKER_END_UP
exit
cat > /tmp/deployleads.sh << 'REMOTE_EOF'
set -e
cd /opt/gush2

echo ---A.snapshot---
TS=$(date +%Y%m%d-%H%M%S)
cp frontend/src/views/projects/ProjectLeads.vue /home/ubuntu/gush2-snapshots/ProjectLeads.vue.online.$TS

echo ---B.replace---
python3 -c "
import base64
data = open('/tmp/ProjectLeads.vue.b64').read()
open('frontend/src/views/projects/ProjectLeads.vue','wb').write(base64.b64decode(data))
"
md5sum frontend/src/views/projects/ProjectLeads.vue

echo ---C.build---
sudo docker compose -f docker-compose.prod.yml --env-file .env.prod build nginx 2>&1 | tail -10

echo ---D.up---
sudo docker compose -f docker-compose.prod.yml --env-file .env.prod up -d nginx 2>&1 | tail -8

echo ---E.ps---
sleep 6
sudo docker ps --format 'table {{.Names}}{{.Status}}' | grep -E "nginx|backend"

echo ---F.verify_chunk---
CHUNK=$(sudo docker exec gush2-nginx ls /usr/share/nginx/html/assets/ | grep -E "^ProjectLeads-" | head -1)
echo "CHUNK=$CHUNK"
sudo docker exec gush2-nginx sh -c "cat /usr/share/nginx/html/assets/$CHUNK" | grep -oE "formFields|getProjectH5|form_fields|formatFormValue" | sort | uniq -c

echo ---END---
REMOTE_EOF

bash /tmp/deployleads.sh; echo MARKER_END_DL
exit
cat > /tmp/get_h5.sh << 'REMOTE_EOF'
echo ---A.fetch_h5---
LOGIN=$(curl -sk -X POST https://admin.gush.cdgushai.com/api/auth/login/ -H 'Content-Type: application/json' -d '{"username":"admin","password":"gaoxiao200606"}')
TOKEN=$(echo "$LOGIN" | python3 -c "import json,sys; print(json.load(sys.stdin).get('access',''))")
echo "TOKEN_LEN=${#TOKEN}"
echo ---B.h5_form_fields---
curl -sk -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com/api/projects/2/h5/" | python3 -c "
import json, sys
d = json.load(sys.stdin)
ff = d.get('form_fields', [])
print('COUNT', len(ff))
for f in ff:
    print('---')
    print('  label:', f.get('label'))
    print('  key:', f.get('key'))
    print('  type:', f.get('type'))
    print('  required:', f.get('required'))
    print('  validate_regex:', repr(f.get('validate_regex','')))
    print('  error_msg:', repr(f.get('error_msg','')))
    print('  options_count:', len(f.get('options', [])))
"
echo ---END---
REMOTE_EOF

bash /tmp/get_h5.sh; echo MARKER_END_H5
exit
cat > /tmp/test_claim.sh << 'REMOTE_EOF'
echo ---A.test_claim---
LOGIN=$(curl -sk -X POST https://admin.gush.cdgushai.com/api/auth/login/ -H 'Content-Type: application/json' -d '{"username":"admin","password":"gaoxiao200606"}')
TOKEN=$(echo "$LOGIN" | python3 -c "import json,sys; print(json.load(sys.stdin).get('access',''))")
echo "TOKEN_LEN=${#TOKEN}"

# 完整模拟 H5 提交 payload
curl -sk -X POST https://admin.gush.cdgushai.com/api/public/claim/ \
  -H 'Content-Type: application/json' \
  -d '{
    "project_id": 2,
    "machine_id": "MACHINE001",
    "form": {
      "name": "测试",
      "phone": "13800001234",
      "f_58xdhl": "male",
      "f_9tbmvw": "25",
      "f_i419k7": "opt1",
      "f_zr1dhg": ["opt1"],
      "f_k1d9vl": ["opt1"]
    }
  }' 2>&1 | head -c 500

echo
echo ---B.list_codes_after---
curl -sk -H "Authorization: Bearer $TOKEN" 'https://admin.gush.cdgushai.com/api/projects/codes/?project=2&status=unused&page_size=3' | python3 -c "
import json,sys
d=json.load(sys.stdin)
r=d.get('results',[])
for x in r[:3]:
    print(x.get('id'), x.get('code'), x.get('status'), 'form=', list((x.get('form_data') or {}).keys()))
" 2>&1 | head
echo ---END---
REMOTE_EOF

bash /tmp/test_claim.sh; echo MARKER_END_TC
exit
bash /tmp/berr.sh; echo MARKER_END_BE
exit
cat > /tmp/berr2.sh << 'REMOTE_EOF'
echo ---recent_log---
sudo docker logs --tail 200 gush2-backend 2>&1 | grep -B 2 -A 30 "Internal Server Error\|Traceback\|claim" | tail -80
echo ---END---
REMOTE_EOF

bash /tmp/berr2.sh; echo MARKER_END_BE2
exit
cat > /tmp/sv.sh << 'REMOTE_EOF'
echo ---A.check_server_views_line_487---
sed -n '480,510p' /opt/gush2/backend/apps/projects/views.py
echo ---B.grep_user_already---
grep -nE "user_already_redeemed_today" /opt/gush2/backend/apps/projects/views.py
echo ---C.grep_defs_around---
grep -nE "^def |^    def |user_already|already_redeemed" /opt/gush2/backend/apps/projects/views.py
echo ---END---
REMOTE_EOF

bash /tmp/sv.sh; echo MARKER_END_SV
exit
cat > /tmp/loop0.sh << 'REMOTE_EOF'
set -e
LOGIN=$(curl -sk -X POST https://admin.gush.cdgushai.com/api/auth/login/ -H 'Content-Type: application/json' -d '{"username":"admin","password":"gaoxiao200606"}')
TOKEN=$(echo "$LOGIN" | python3 -c "import json,sys; print(json.load(sys.stdin).get('access',''))")
echo "TOKEN_LEN=${#TOKEN}"

echo "===PROJECT_2_DETAIL==="
curl -sk -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com/api/projects/projects/2/" | python3 -m json.tool | head -60

echo "===H5_RATE_LIMIT_AND_VALIDITY==="
curl -sk -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com/api/projects/2/h5/" | python3 -c "
import json, sys
d = json.load(sys.stdin)
print('rate_limit:', d.get('rate_limit'))
print('code_length:', 'n/a (in project)')
print('form_fields_count:', len(d.get('form_fields', [])))
print('submit_button:', d.get('submit_button'))
print('privacy:', d.get('privacy'))
"

echo "===BIND_MACHINES==="
curl -sk -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com/api/projects/projects/2/" | python3 -c "
import json,sys
d=json.load(sys.stdin)
print('id:', d.get('id'))
print('name:', d.get('name'))
print('status:', d.get('status'))
print('starts_at:', d.get('starts_at'))
print('ends_at:', d.get('ends_at'))
print('code_length:', d.get('code_length'))
print('code_validity_seconds:', d.get('code_validity_seconds'))
print('code_validity_days:', d.get('code_validity_days'))
print('max_per_user:', d.get('max_per_user'))
print('daily_per_user_per_machine:', d.get('daily_per_user_per_machine'))
print('daily_window_start_hour:', d.get('daily_window_start_hour'))
"

echo "===ALL_MACHINES_BRIEF==="
curl -sk -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com/api/devices/machines/?page_size=10" | python3 -c "
import json, sys
d = json.load(sys.stdin)
items = d.get('results', d) if isinstance(d, dict) else d
for m in items[:10]:
    print(' -', m.get('machine_id'), m.get('subdomain'), m.get('status'), 'sig=', m.get('signal_strength'))
"
echo "===END==="
REMOTE_EOF

bash /tmp/loop0.sh; echo MARKER_END_L0
exit
cat > /tmp/loop1.sh << 'REMOTE_EOF'
echo "===CLAIM_1: openid=oTEST001, MACHINE001==="
RESP=$(curl -sk -X POST https://admin.gush.cdgushai.com/api/public/claim/ \
  -H 'Content-Type: application/json' \
  -d '{
    "project_id": 2,
    "machine_id": "MACHINE001",
    "form": {
      "name": "测试用户1",
      "phone": "13800001234",
      "f_58xdhl": "male",
      "f_9tbmvw": "25",
      "f_i419k7": "opt1",
      "f_zr1dhg": ["opt1"],
      "f_k1d9vl": ["opt1"]
    },
    "visit_id": null
  }')
echo "RESP=$RESP" | head -c 600
echo
CODE1=$(echo "$RESP" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('code',''))" 2>/dev/null)
echo "CODE1=$CODE1"
echo "CODE1=$CODE1" > /tmp/claim1_code.txt
echo "===END==="
REMOTE_EOF

bash /tmp/loop1.sh; echo MARKER_END_L1
exit
cat > /tmp/berr3.sh << 'REMOTE_EOF'
echo ---recent_log---
sudo docker logs --tail 200 gush2-backend 2>&1 | grep -B 2 -A 20 "Internal Server Error" | tail -50
echo ---END---
REMOTE_EOF

bash /tmp/berr3.sh; echo MARKER_END_BE3
exit
cat > /tmp/berr4.sh << 'REMOTE_EOF'
echo ---full_traceback---
sudo docker logs --tail 500 gush2-backend 2>&1 | grep -B 1 -A 50 "Internal Server Error" | tail -80
echo ---END---
REMOTE_EOF

bash /tmp/berr4.sh; echo MARKER_END_BE4
exit
cat > /tmp/loop_a.sh << 'REMOTE_EOF'
echo "===CLAIM_2: 同一 openid + MACHINE001 同一天==="
curl -sk -X POST https://admin.gush.cdgushai.com/api/public/claim/ \
  -H 'Content-Type: application/json' \
  -d '{
    "project_id": 2,
    "machine_id": "MACHINE001",
    "form": {
      "name": "测试用户1第二次",
      "phone": "13800001234",
      "f_58xdhl": "male", "f_9tbmvw": "25", "f_i419k7": "opt1",
      "f_zr1dhg": ["opt1"], "f_k1d9vl": ["opt1"],
      "openid": "oTEST001"
    }
  }' -o /tmp/claim2.txt -w "HTTP=%{http_code}\n"
head -c 300 /tmp/claim2.txt; echo

echo "===CLAIM_3: 异 machine (MACHINE002 offline)==="
curl -sk -X POST https://admin.gush.cdgushai.com/api/public/claim/ \
  -H 'Content-Type: application/json' \
  -d '{
    "project_id": 2,
    "machine_id": "MACHINE002",
    "form": {
      "name": "测试跨机", "phone": "13800009999",
      "f_58xdhl": "female", "f_9tbmvw": "30", "f_i419k7": "opt1",
      "f_zr1dhg": ["opt1"], "f_k1d9vl": ["opt1"],
      "openid": "oTEST001"
    }
  }' -o /tmp/claim3.txt -w "HTTP=%{http_code}\n"
head -c 300 /tmp/claim3.txt; echo

echo "===CLAIM_4: 异 openid 同一 machine==="
curl -sk -X POST https://admin.gush.cdgushai.com/api/public/claim/ \
  -H 'Content-Type: application/json' \
  -d '{
    "project_id": 2,
    "machine_id": "MACHINE001",
    "form": {
      "name": "异人", "phone": "13911112222",
      "f_58xdhl": "male", "f_9tbmvw": "40", "f_i419k7": "opt1",
      "f_zr1dhg": ["opt1"], "f_k1d9vl": ["opt1"],
      "openid": "oTEST002"
    }
  }' -o /tmp/claim4.txt -w "HTTP=%{http_code}\n"
head -c 300 /tmp/claim4.txt; echo

echo "===CLAIM_5: 异 openid 异 machine==="
curl -sk -X POST https://admin.gush.cdgushai.com/api/public/claim/ \
  -H 'Content-Type: application/json' \
  -d '{
    "project_id": 2,
    "machine_id": "MACHINE002",
    "form": {
      "name": "异人异机", "phone": "13933334444",
      "f_58xdhl": "female", "f_9tbmvw": "50", "f_i419k7": "opt1",
      "f_zr1dhg": ["opt1"], "f_k1d9vl": ["opt1"],
      "openid": "oTEST003"
    }
  }' -o /tmp/claim5.txt -w "HTTP=%{http_code}\n"
head -c 300 /tmp/claim5.txt; echo

echo "===END==="
REMOTE_EOF

bash /tmp/loop_a.sh; echo MARKER_END_LA
exit
cat > /tmp/loop_b.sh << 'REMOTE_EOF'
echo "===INJECT_B: 直接写一条 unused 码进 DB==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
INSERT INTO gush_redeem_code (code, project_id, status, expires_at, created_at, updated_at, user_openid, user_nickname, form_data)
VALUES ('LOOP01', 2, 'unused', DATE_ADD(NOW(), INTERVAL 1 DAY), NOW(), NOW(), 'oLOOP01', 'LoopTest', JSON_OBJECT('name','LoopTest','phone','13800005555'));
SELECT id, code, status, expires_at, user_openid, user_nickname FROM gush_redeem_code WHERE code='LOOP01';
" 2>&1 | grep -v Warning

echo "===EXCHANGE_B: 模拟 Qt 核销 LOOP01==="
SECRET='Mooo_-IO-7qfhEphKdB9xzpKB4cNp940R_FvUc7pRhk'
curl -sk -X POST https://admin.gush.cdgushai.com/api/public/redeem/api/exchange/ \
  -H 'Content-Type: application/json' \
  -d "{
    \"code\": \"LOOP01\",
    \"machine_id\": \"MACHINE001\",
    \"secret\": \"$SECRET\"
  }" -o /tmp/exchange_b.txt -w "HTTP=%{http_code}\n"
head -c 500 /tmp/exchange_b.txt; echo
echo "---END---"
REMOTE_EOF

bash /tmp/loop_b.sh; echo MARKER_END_LB
exit
cat > /tmp/qtex.sh << 'REMOTE_EOF'
echo ---qt_exchange_start---
sed -n '787,870p' /opt/gush2/backend/apps/projects/views.py
echo ---END---
REMOTE_EOF

bash /tmp/qtex.sh; echo MARKER_END_QTEX
exit
cat > /tmp/desc.sh << 'REMOTE_EOF'
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "DESCRIBE gush_redeem_code;" 2>&1 | grep -v Warning
REMOTE_EOF

bash /tmp/desc.sh; echo MARKER_END_D
exit
cat > /tmp/loop_b2.sh << 'REMOTE_EOF'
echo "===INJECT_B_V2==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
INSERT INTO gush_redeem_code (code, project_id, status, expires_at, created_at, user_openid, user_nickname, form_data, claim_machine_id, device_fp)
VALUES ('LOOP01', 2, 'unused', DATE_ADD(NOW(), INTERVAL 1 DAY), NOW(), 'oLOOP01', 'LoopTest', JSON_OBJECT('name','LoopTest'), 'MACHINE001', 'loop01fp');
SELECT id, code, status, expires_at, used_on_channel_code, user_openid, claim_machine_id FROM gush_redeem_code WHERE code='LOOP01';
" 2>&1 | grep -v Warning

echo "===EXCHANGE_B_V2: 核销 LOOP01==="
SECRET='Mooo_-IO-7qfhEphKdB9xzpKB4cNp940R_FvUc7pRhk'
curl -sk -X POST https://admin.gush.cdgushai.com/api/public/redeem/api/exchange/ \
  -H 'Content-Type: application/json' \
  -d "{\"code\":\"LOOP01\",\"machine_id\":\"MACHINE001\",\"secret\":\"$SECRET\"}" \
  -o /tmp/ex2.txt -w "HTTP=%{http_code}\n"
cat /tmp/ex2.txt; echo

echo "===LOOP01_STATUS_AFTER==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT id, code, status, used_at, used_on_machine_id, used_on_channel_code FROM gush_redeem_code WHERE code='LOOP01';" 2>&1 | grep -v Warning
echo "===END==="
REMOTE_EOF

bash /tmp/loop_b2.sh; echo MARKER_END_LB2
exit
cat > /tmp/loop_b3.sh << 'REMOTE_EOF'
echo "===INJECT_B_V3==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
INSERT INTO gush_redeem_code (code, project_id, status, expires_at, created_at, user_openid, user_nickname, form_data, claim_machine_id, device_fp, used_on_channel_code)
VALUES ('LOOP01', 2, 'unused', DATE_ADD(NOW(), INTERVAL 1 DAY), NOW(), 'oLOOP01', 'LoopTest', JSON_OBJECT('name','LoopTest'), 'MACHINE001', 'loop01fp', '');
SELECT id, code, status, expires_at, user_openid, claim_machine_id, used_on_channel_code FROM gush_redeem_code WHERE code='LOOP01';
" 2>&1 | grep -v Warning

echo "===EXCHANGE_B_V3==="
SECRET='Mooo_-IO-7qfhEphKdB9xzpKB4cNp940R_FvUc7pRhk'
curl -sk -X POST https://admin.gush.cdgushai.com/api/public/redeem/api/exchange/ \
  -H 'Content-Type: application/json' \
  -d "{\"code\":\"LOOP01\",\"machine_id\":\"MACHINE001\",\"secret\":\"$SECRET\"}" \
  -o /tmp/ex3.txt -w "HTTP=%{http_code}\n"
cat /tmp/ex3.txt; echo

echo "===LOOP01_AFTER==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "SELECT id, code, status, used_at, used_on_machine_id, used_on_channel_code FROM gush_redeem_code WHERE code='LOOP01';" 2>&1 | grep -v Warning
echo "===END==="
REMOTE_EOF

bash /tmp/loop_b3.sh; echo MARKER_END_LB3
exit
cat > /tmp/loop_b4.sh << 'REMOTE_EOF'
echo "===INJECT_B_V4: 绕过 user_already (openid 设空)==="
# 测 line 852 的 user_already_redeemed_today 当 user_openid='' 时是否还抛
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
DELETE FROM gush_redeem_code WHERE code='LOOP01';
INSERT INTO gush_redeem_code (code, project_id, status, expires_at, created_at, user_openid, user_nickname, form_data, claim_machine_id, device_fp, used_on_channel_code)
VALUES ('LOOP02', 2, 'unused', DATE_ADD(NOW(), INTERVAL 1 DAY), NOW(), '', 'LoopTest2', JSON_OBJECT('name','LoopTest2'), 'MACHINE001', 'loop02fp', '');
SELECT id, code, status, user_openid FROM gush_redeem_code WHERE code IN ('LOOP01','LOOP02');
" 2>&1 | grep -v Warning

echo "===EXCHANGE_B_V4: openid=空==="
SECRET='Mooo_-IO-7qfhEphKdB9xzpKB4cNp940R_FvUc7pRhk'
curl -sk -X POST https://admin.gush.cdgushai.com/api/public/redeem/api/exchange/ \
  -H 'Content-Type: application/json' \
  -d "{\"code\":\"LOOP02\",\"machine_id\":\"MACHINE001\",\"secret\":\"$SECRET\"}" \
  -o /tmp/ex4.txt -w "HTTP=%{http_code}\n"
cat /tmp/ex4.txt; echo
echo "===END==="
REMOTE_EOF

bash /tmp/loop_b4.sh; echo MARKER_END_LB4
exit
cat > /tmp/qtex2.sh << 'REMOTE_EOF'
echo ---qt_exchange_845_855---
sed -n '845,855p' /opt/gush2/backend/apps/projects/views.py
echo ---END---
REMOTE_EOF

bash /tmp/qtex2.sh; echo MARKER_END_QTEX2
exit
cat > /tmp/loop_x.sh << 'REMOTE_EOF'
LOGIN=$(curl -sk -X POST https://admin.gush.cdgushai.com/api/auth/login/ -H 'Content-Type: application/json' -d '{"username":"admin","password":"gaoxiao200606"}')
TOKEN=$(echo "$LOGIN" | python3 -c "import json,sys; print(json.load(sys.stdin).get('access',''))")

echo "===A.ADMIN_LISTS==="
for p in "/api/projects/projects/" "/api/devices/machines/" "/api/products/products/" "/api/projects/codes/?project=2&page_size=5"; do
  printf "%-50s " "$p"
  curl -sk -o /dev/null -w "HTTP=%{http_code} time=%{time_total}\n" -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com$p"
done

echo "===B.PUBLIC_H5_PAGE==="
curl -sk -o /dev/null -w "HTTP=%{http_code} time=%{time_total} bytes=%{size_download}\n" "https://machine001.gush.cdgushai.com/p/2/?preview=1"

echo "===C.PUBLIC_REDEEM_DASHBOARD==="
curl -sk -o /dev/null -w "HTTP=%{http_code} time=%{time_total} bytes=%{size_download}\n" "https://admin.gush.cdgushai.com/client/KYQYTsOBI48y6f6_yhQ_xOFB_gJK9FjwH81hIlIrV78/"

echo "===D.PUBLIC_PROJECT_DASHBOARD_JSON==="
curl -sk -o /dev/null -w "HTTP=%{http_code} time=%{time_total}\n" "https://admin.gush.cdgushai.com/api/public/project-dashboard/KYQYTsOBI48y6f6_yhQ_xOFB_gJK9FjwH81hIlIrV78/"

echo "===E.QT_CHANNELS (machine001)==="
SECRET='Mooo_-IO-7qfhEphKdB9xzpKB4cNp940R_FvUc7pRhk'
curl -sk -o /tmp/ch.json -w "HTTP=%{http_code}\n" "https://admin.gush.cdgushai.com/api/public/redeem/api/channels/?machine_id=MACHINE001&secret=$SECRET"
python3 -c "
import json
d = json.load(open('/tmp/ch.json'))
chs = d.get('channels', d if isinstance(d, list) else [])
if isinstance(chs, list) and chs:
    print('CHANNELS count=', len(chs))
    for c in chs[:5]:
        print(' -', c.get('code'), 'stock=', c.get('current_stock'), 'status=', c.get('status'))
    if len(chs) > 5:
        print(' ... and', len(chs)-5, 'more')
elif isinstance(chs, list):
    print('CHANNELS list empty')
else:
    print('keys:', list(d.keys())[:10])
"

echo "===F.LED_PAGE==="
curl -sk -o /dev/null -w "HTTP=%{http_code}\n" "https://machine001.gush.cdgushai.com/led/"

echo "===G.DEVICE_CONSOLE_QT==="
curl -sk -o /dev/null -w "HTTP=%{http_code}\n" "https://machine001.gush.cdgushai.com/device/"

echo "===END==="
REMOTE_EOF

bash /tmp/loop_x.sh; echo MARKER_END_LX
exit
cat > /tmp/r1.sh << 'REMOTE_EOF'
echo ---nginx_led_device---
grep -nE "location /device|location /led|location ~" /opt/gush2/docker/nginx/nginx.conf
echo ---views_device---
grep -rnE "def public_led_page|def public_device|def qt_console|def device_console" /opt/gush2/backend/apps/ 2>&1 | head
echo ---END---
REMOTE_EOF

bash /tmp/r1.sh; echo MARKER_END_R1
exit
cat > /tmp/r2.sh << 'REMOTE_EOF'
echo "===F2.LED_PAGE /led/MACHINE001/==="
curl -sk -o /dev/null -w "HTTP=%{http_code} time=%{time_total} bytes=%{size_download}\n" "https://machine001.gush.cdgushai.com/led/MACHINE001/"

echo "===G2.DEVICE_CONSOLE /device/MACHINE001/==="
curl -sk -o /dev/null -w "HTTP=%{http_code} time=%{time_total} bytes=%{size_download}\n" "https://machine001.gush.cdgushai.com/device/MACHINE001/"
echo "===END==="
REMOTE_EOF

bash /tmp/r2.sh; echo MARKER_END_R2
exit
cat > /tmp/r3.sh << 'REMOTE_EOF'
LOGIN=$(curl -sk -X POST https://admin.gush.cdgushai.com/api/auth/login/ -H 'Content-Type: application/json' -d '{"username":"admin","password":"gaoxiao200606"}')
TOKEN=$(echo "$LOGIN" | python3 -c "import json,sys; print(json.load(sys.stdin).get('access',''))")

echo "===STATS_PROJECT_2==="
curl -sk -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com/api/projects/2/stats/" -o /tmp/stats.json -w "HTTP=%{http_code}\n"
head -c 800 /tmp/stats.json; echo
echo

echo "===STATS_DASHBOARD==="
curl -sk -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com/api/stats/dashboard/" -o /tmp/dash.json -w "HTTP=%{http_code}\n"
head -c 800 /tmp/dash.json; echo
echo

echo "===DASHBOARD_PROJ_2==="
curl -sk -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com/api/stats/dashboard/?project=2" -o /tmp/dash2.json -w "HTTP=%{http_code}\n"
head -c 800 /tmp/dash2.json; echo
echo

echo "===DASHBOARD_LEADS==="
curl -sk -H "Authorization: Bearer $TOKEN" "https://admin.gush.cdgushai.com/api/leads/?project=2&page_size=3" -o /tmp/leads.json -w "HTTP=%{http_code}\n"
head -c 600 /tmp/leads.json; echo

echo "===END==="
REMOTE_EOF

bash /tmp/r3.sh; echo MARKER_END_R3
exit
cat > /tmp/r4.sh << 'REMOTE_EOF'
echo "===CLEANUP_TEST_CODES==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
DELETE FROM gush_redeem_code WHERE code IN ('LOOP01','LOOP02');
SELECT code, status FROM gush_redeem_code WHERE code IN ('LOOP01','LOOP02');
" 2>&1 | grep -v Warning

echo "===CURRENT_UNUSED_FOR_PROJECT_2==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
SELECT id, code, status, expires_at, TIMESTAMPDIFF(SECOND, NOW(), expires_at) AS expire_in_sec, user_openid, claim_machine_id
FROM gush_redeem_code WHERE project_id=2 AND status='unused' ORDER BY id DESC LIMIT 5;
" 2>&1 | grep -v Warning

echo "===EXPIRES_AT_HOURS_FOR_UNUSED==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
SELECT
  MIN(TIMESTAMPDIFF(SECOND, NOW(), expires_at)) AS min_sec,
  MAX(TIMESTAMPDIFF(SECOND, NOW(), expires_at)) AS max_sec,
  AVG(TIMESTAMPDIFF(SECOND, NOW(), expires_at)) AS avg_sec,
  COUNT(*) AS total_unused
FROM gush_redeem_code WHERE project_id=2 AND status='unused';
" 2>&1 | grep -v Warning

echo "===CHANNELS_OF_MACHINE001==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
SELECT channel_code, status, current_stock, capacity
FROM gush_channel WHERE machine_id=(SELECT id FROM gush_machine WHERE machine_id='MACHINE001')
ORDER BY channel_code LIMIT 10;
" 2>&1 | grep -v Warning

echo "===END==="
REMOTE_EOF

bash /tmp/r4.sh; echo MARKER_END_R4
exit
cat > /tmp/r5.sh << 'REMOTE_EOF'
echo "===SERVER_TIMEZONE==="
date
date -u
echo "TIMESTAMP_NOW=$(date +%s)"
echo "MACHINE001_NOW_TIME=$(sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e 'SELECT NOW(), UTC_TIMESTAMP();' 2>&1 | grep -v Warning | tail -3)"
echo

echo "===CODE_AGE_DIST==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
SELECT
  status, COUNT(*) AS cnt,
  AVG(TIMESTAMPDIFF(SECOND, created_at, NOW())) AS avg_age_sec,
  MIN(TIMESTAMPDIFF(SECOND, created_at, NOW())) AS min_age_sec,
  MAX(TIMESTAMPDIFF(SECOND, created_at, NOW())) AS max_age_sec
FROM gush_redeem_code WHERE project_id=2 GROUP BY status;
" 2>&1 | grep -v Warning

echo "===STATUS_BREAKDOWN_PROJECT_2==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
SELECT status, COUNT(*) AS n FROM gush_redeem_code WHERE project_id=2 GROUP BY status;
" 2>&1 | grep -v Warning

echo "===RECENT_USED_CODES_FOR_PROJ_2==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
SELECT id, code, status, used_at, used_on_machine_id, used_on_channel_code, user_openid
FROM gush_redeem_code WHERE project_id=2 AND status='used' ORDER BY used_at DESC LIMIT 5;
" 2>&1 | grep -v Warning

echo "===DISPENSE_LOG==="
sudo docker exec gush2-mysql mysql -ugush -p'7dvHnPbGFTP2Vi_DYevMWtNp0zxjJTWl' gush2 -e "
DESCRIBE gush_dispense_log; SELECT COUNT(*) FROM gush_dispense_log;
" 2>&1 | grep -v Warning

echo "===END==="
REMOTE_EOF

bash /tmp/r5.sh; echo MARKER_END_R5
exit
