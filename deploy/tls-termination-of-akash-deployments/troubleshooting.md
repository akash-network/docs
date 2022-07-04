# Troubleshooting

* In this section we review a couple of common problems encountered

## **Mixed Content Errors**

In the example below you’ve noticed the “https” was set - “https://ghost.akash.pro”**.** That is to make sure the backend (Ghost) is serving the HTTPD links only, since our goal was to enable HTTPS via TLS termination over Cloudflare.

In situations when the backend server is not HTTPS aware, you will see the content would not load due to a mixed content (this is when the server is offering non-HTTPS links while being accessed over HTTPS).

Here is an example of that, the deployment is set to “http://ghost.akash.pro” while “https://ghost.akash.pro” is opened in the browser.

![](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-LrNFlfuifzmQ\_NMKu9C-887967055%2Fuploads%2F3zaPRHd62wRj1oQrewrN%2FcloudflareMixedMedia.png?alt=media\&token=30738db8-7611-4480-9c71-076c6a839d32)
