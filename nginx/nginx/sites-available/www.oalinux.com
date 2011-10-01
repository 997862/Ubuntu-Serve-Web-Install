
server {
        listen   80;

        server_name  www.oalinux.com;

        access_log  /var/log/nginx/www.oalinux.com.access.log;

        location / {
                root   /*/*/www.oalinux.com/;
                index  index.php index.html index.htm;
                # serve static files directly
                if (-f $request_filename) {
                        access_log        off;
                        expires           30d;
                        break;
                }

        }


	location ~ ^/images/.*\.(php|php5)$ 
        { 
		  deny all; 
        } 

        location ~ \.php$ {
                fastcgi_pass   127.0.0.1:9000;
                fastcgi_index  index.php;
                set  $script     $uri;
                set  $path_info  "";
                if ($uri ~ "^(.+\.php)(/.*)") {
                  set  $script     $1;
                  set  $path_info  $2;                
		}
                include fastcgi_params;
                fastcgi_param   SCRIPT_FILENAME  /*/*/www.oalinux.com$script;
                fastcgi_param   SCRIPT_NAME $script;
                fastcgi_param   PATH_INFO        $path_info;
        }

	location ~* \.(rar|zip|sql|tar.gz|tar.bz2)$ {
	        return 403;
		}


        location ~ /\.ht {
                deny  all;
        }
}
