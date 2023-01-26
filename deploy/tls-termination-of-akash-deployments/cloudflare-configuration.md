# Cloudflare Configuration



## Point Domain Name to Deployment IP

These configs are necessary in Cloudflare:

* Point the domain name of the deployment to the IP address of the deployment captured in the last step
* Set Proxy Status to `Proxied`

![](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-LrNFlfuifzmQ\_NMKu9C-887967055%2Fuploads%2FPkRELRx4bWZqN65xAtdo%2FcloudflareDNS.png?alt=media\&token=f0dd85fd-72f1-4247-baaa-43391005dc4b)

### Cloudflare Recommendation

Cloudflare recommends orange-clouding the record so that any dig query against that record returns a Cloudflare IP address and your origin server IP address remains concealed from the public.&#x20;

DNS proxied means it will be shown a Cloudflare IP if you look it up. Thus all attacks at that domain will DDoS Cloudflare and not you host directly. Non proxied means all traffic goes directly to your own IP without Cloudflare being a safety net in front.

## **Ensure SSL/TLS Encryption Set to Full**

In most situations we want Full TLS mode specified in Cloudflare based on:

* **Full TLS termination mode:** if the backend understands it is behind the Full TLS termination balancer (be that Cloudflare or anything else), it should then keep serving HTTPS
* **Flexible TLS termination mode:** this is when the backend is only serving HTTP requests and does not understand that something is terminating the TLS in front, then it will only work if it is NOT trying to serve full scheme URI's (i.e. uri's containing "http://" in them). Otherwise you get a mixed content error (see the comment on Mixed Content error is below).

> _**NOTE**_ - we advise using a **Full TLS termination mode** since Akash deployments exposed over the port 80/tcp HTTP (as: 80 in SDL manifest) are also automatically getting exposed over the 443/tcp HTTPS (TLS), though with the default self-signed certificates. This mode will ensure the traffic between Cloudflare and the Akash deployment gets encrypted.

![](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-LrNFlfuifzmQ\_NMKu9C-887967055%2Fuploads%2FnbC4Bqsj8Eo4nTCMNgp1%2FcloudflareTLS.png?alt=media\&token=af45f034-a99b-4125-af5e-7e8c9ecd357c)
