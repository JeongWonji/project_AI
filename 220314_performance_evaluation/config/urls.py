"""config URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
# Root URLConf(http://127.0.0.1:8000/)
from django.contrib import admin
from django.urls import path, include
from django.views.generic.base import TemplateView
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', TemplateView.as_view(template_name='index.html'), name='home'),  # Home Page
    path('home/', TemplateView.as_view(template_name='index2.html'), name='home2'),  # Home Page
    path('admin/', admin.site.urls),                                          # Admin Page
    path('main/', include('main.urls'),),                                      # login 후 Home Page
    path('users/', include('users.urls')),                                    # login, 회원가입 page                                     # 병원 map page
    path('probbs/', include('probbs.urls')),                                     # 전문의 게시판 page
] + static(settings.MEDIA_URL,
           document_root=settings.MEDIA_ROOT)

if settings.DEBUG:
    if "debug_toolbar" in settings.INSTALLED_APPS:
        import debug_toolbar
        urlpatterns = [path("__debug__/", include(debug_toolbar.urls))] + urlpatterns

