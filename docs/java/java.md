# 1 根据content-type获取文件后缀名:
```
        <dependency>
			<groupId>org.apache.tika</groupId>
			<artifactId>tika-core</artifactId>
			<version>1.14</version>
	</dependency>
```
```
MimeTypes allTypes = MimeTypes.getDefaultMimeTypes();
HttpEntity entity = response.getEntity();

String contentType = entity.getContentType().getValue();
MimeType jpeg = allTypes.forName(contentType);
String ext = jpeg.getExtension();
```
#2.阿里推荐使用的线程池
```
private BlockingQueue<Runnable>			block				= new LinkedBlockingQueue<Runnable>();
private final ThreadPoolExecutor		threadFacory	= new ThreadPoolExecutor(100, 100, 60, TimeUnit.SECONDS, block);
```