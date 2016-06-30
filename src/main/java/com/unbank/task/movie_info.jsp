<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="am-panel">
	<ol class="am-panel-hd theme-panel-hd am-breadcrumb" style="margin-bottom:0">
		<li><a href="${pageContext.request.contextPath}/" class="am-icon-home">首页</a></li>
		<li><a href="${pageContext.request.contextPath }/all/1.htm">电影</a></li>
		<li class="am-active">正文</li>
	</ol>
	<article class="am-panel-bd film-article">
		<!-- head begin -->
		<h1 class="film-title am-text-truncate am-text-warning" title="${movie.title }">${movie.title }</h1>
		<i class="film-rank am-serif">${movie.rank }</i>
		<ul class="film-info am-thumbnails am-cf" style="color:#777; border-bottom: 1px solid #eee">
			<li class="am-fl am-icon-calendar am-text-nowrap" title="发布时间"> <fmt:formatDate value="${movie.deliveryTime }" pattern="yyyy-MM-dd hh:mm:ss"/></li>
			<li class="am-fl am-icon-user am-text-nowrap" title="作者"> ${movie.author }</li>
			<li class="am-fl am-icon-map-marker am-text-nowrap"><a style="font-weight: bold" class="am-text-primary" href="${pageContext.request.contextPath }/${movie.id }.htm" title="来源"> ${movie.origin }</a></li>
			<li class="am-fl am-icon-eye am-text-nowrap" title="浏览次数"> ${movie.clickCount }</li>
			<li class="am-fl am-text-nowrap">豆瓣评分：${movie.rank }</li>
		</ul>
		<!-- head end -->
		<!-- body begin -->
		<div class="am-alert am-alert-secondary">
			<strong>摘要：</strong>${movie.summary }
		</div>
		<div class="am-cf">
		  <div class="am-align-left am-u-md-5 " style="padding-left:0">
		  	<c:set var="title" value="b${movie.title }"></c:set>
		    <img onerror="this.src='${pageContext.request.contextPath }/images/nocoverpic.png'" 
		    	src="${movie.coverPic }" style="width: 100%; height: auto;" 
		    	alt="${fn:split(fn:split(fn:split(title,'》')[0],'《')[1],'/')[0] }海报"/>
		  </div>
		  <div class="am-article-lead">${fn:replace(fn:replace(movie.content,br,"<br/>"),' ','&nbsp;&nbsp;') }</div>
		</div>
		<!-- body end -->
		<c:set var="classes" value="${fn:split('am-btn am-btn-primary am-btn-xs am-radius,am-btn am-btn-success am-btn-xs am-radius,am-btn am-btn-secondary am-btn-xs am-radius,am-btn am-btn-warning am-btn-xs am-radius,am-btn am-btn-danger am-btn-xs am-radius',',')}"></c:set>
		<!-- download begin -->
		<div class="am-alert am-alert-secondary am-radius" style="position: relative;padding:3em 3em 1em 3em">
			<span class="film-download-head am-badge am-badge-warning am-radius">下载地址</span>
			<ul class="am-cf">
			<c:forEach items="${movie.downloadInfos }" var="downloadInfo" varStatus="status">
				<c:if test="${downloadInfo.category.name=='迅雷下载' }">
					<li class="am-fl am-margin-right-xs am-margin-bottom-xs">
						<a class="${classes[(status.count - 1) % 5] }" onclick="xldown('${downloadInfo.url }')" oncontextmenu="ThunderNetwork_SetHref(this)" href="javascript:void(0)">迅雷下载</a> 
					</li>
				</c:if>
				<c:if test="${downloadInfo.category.name=='旋风下载' }">
					<li class="am-fl am-margin-right-xs am-margin-bottom-xs">
						<a class="${classes[(status.count - 1) % 5] }" onclick="XFLIB.startDownload(this,event)" qhref="${downloadInfo.url }" href="javascript:void(0)">旋风下载</a> 
					</li>
				</c:if>
				<c:if test="${downloadInfo.category.name!='迅雷下载' && downloadInfo.category.name!='旋风下载' }">
					<li class="am-fl am-margin-right-xs am-margin-bottom-xs">
					<a class="${classes[(status.count - 1) % 5] }" href="${downloadInfo.url }" target="_blank">
						${downloadInfo.category.name}<c:if test="${downloadInfo.password != null && downloadInfo.password != '' && downloadInfo.password != 'none' }">(密码:${downloadInfo.password })</c:if>
					</a>
					</li>
				</c:if>
			</c:forEach>

				<li class="am-fl am-margin-right-xs am-margin-bottom-xs">
					<a class="am-btn am-btn-secondary am-btn-xs am-radius" href="${pageContext.request.contextPath}/share/p1.htm"  target="_blank">VIP账号免费抢</a>
				</li>
			</ul>
		</div>
		<c:if test="${fn:length(playUrls) > 0 }">
		<div class="am-alert am-alert-secondary am-radius" style="position: relative;">
			<span class="film-download-head am-badge am-badge-warning am-radius">在线播放列表</span>
			<ul class="am-margin-top-xl am-form am-form-horizontal">
			<c:forEach items="${playUrls }" var="pu">
				<li class="am-form-group">
					<div class="am-u-md-9">
						<input style="background: #fff" class="am-form-field" readonly value="http://bd-dy.com/play/${pu.id }.htm"/>
					</div>
					<div class="am-btn-group am-u-md-3 am-fr">
						<a class="am-btn am-btn-danger" href="${pageContext.request.contextPath}/play/${pu.id }.htm">复制</a>
						<a class="am-btn am-btn-danger" href="${pageContext.request.contextPath}/play/${pu.id }.htm" target="_blank">播放</a>
					</div>
				</li>
			</c:forEach>
			</ul>
		</div>
		</c:if>
		<!-- download end -->
		<!-- slide pic begin -->
		<div class="am-slider am-slider-default" data-am-flexslider="{playAfterPaused: 8000}">
		  <ul class="am-slides">
		  <c:forEach items="${fn:split(movie.pic, ',') }" var="url">
		  	<li>
		  		<img onerror="this.src='${pageContext.request.contextPath }/images/nocutpic.jpg'" src="${url }" alt="${movie.title }截图"/>
			</li>
		  </c:forEach>
		  </ul>
		</div>
		<!-- slide pic end -->
		<!-- tag begin -->
		<div>
			<i class="am-icon-tags am-badge am-badge-warning am-radius"> 标签:</i>
		<c:forEach items="${movie.tags }" var="tag">
			<a class="am-btn am-btn-success am-badge am-badge-success am-round am-margin-right-xs" href="${pageContext.request.contextPath }/t/${tag.id }-1.htm">${tag.name }</a>	
		</c:forEach>
		</div>
		<!-- tag end -->
		<hr>
		<!-- article bottom begin -->
		<div class="am-cf">
			<span class="am-u-md-2 am-u-sm-12">
				<button onclick="thumb.up(${movie.id })" type="button" class="am-btn am-btn-warning am-text-center am-radius am-u-md-5 am-u-sm-12 am-margin-bottom-xs" style="padding:0.5em 0.8em">
					<strong id="up">${movie.love }</strong>
					<p style="text-indent: 0;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25)"><i class="am-icon-thumbs-o-up"></i></p>
				</button>
				<button onclick="thumb.down(${movie.id })" type="button" class="am-btn am-btn-primary am-text-center am-radius am-u-md-5 am-u-sm-12 am-margin-bottom-xs" style="padding:0.5em 0.8em">
					<strong id="down">${movie.unlove }</strong>
					<p style="text-indent: 0;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25)"><i class="am-icon-thumbs-o-down"></i></p>
				</button>
			</span>
			<ul class="am-u-md-10 am-u-sm-12 am-serif">
				<li>
					<strong>上一篇：</strong>
					<c:if test="${pre==null }">没有了</c:if>
					<c:if test="${pre!=null }">
						<a class=" film-pre-next-a" href="${pageContext.request.contextPath }/${pre.id}.htm" >${pre.title }</a>
					</c:if>
				</li>
				<li>
					<strong>下一篇：</strong>
					<c:if test="${next==null }">没有了</c:if>
					<c:if test="${next!=null }">
						<a class=" film-pre-next-a" href="${pageContext.request.contextPath }/${next.id}.htm" >${next.title }</a>
					</c:if>
				</li>
			</ul>
		</div>
		<!-- article bottom end -->
	</article>
</div>
<script>
	var thumb = {
			
			up : function(id) {
				var c = getCookie("thumb" + id);
				if (c == null) {
					$.getJSON("up/" + id, function(data) {
						if (data.status == 0) {
							$('#up').html(parseInt($('#up').html()) + 1);
							setCookie("thumb" + id, true);
						}
					});
				}
			},
	
			down : function(id) {
				var c = getCookie("thumb" + id);
				if (c == null) {
					$.getJSON("down/" + id, function(data) {
						if (data.status == 0) {
							$('#down').html(parseInt($('#down').html()) + 1);
							setCookie("thumb" + id, true);
						}
					});
				}
			}
			
	};
	function getCookie(name) {
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
		if(arr=document.cookie.match(reg))
			return unescape(arr[2]);
		else
			return null;
	}
	function setCookie(name,value) {
		var Days = 11130;
		var exp = new Date();
		exp.setTime(exp.getTime() + Days*24*60*60*1000);
		document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
	}
</script>