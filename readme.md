first [install nix](https://nixos.org/download.html)

Then run the following commands to reproduce the error:

```
nix-shell
clojure -X:build uber
nix-build
```

At the moment it also doesn't work to re-build without internet access, which can be simulated with the below commands. I will note though that this built in the past, and I don't remember what I've changed since then.

```
sudo unshare -n
sudo su <username>
nix-shell
clojure -X:build uber
```

