## 是否要把go.sum提交到仓库

#### FAQ: Should I check go.sum into git?

A: Generally yes. With it, anyone with your sources doesn't have to trust other GitHub repositories and custom import path owners. Something better is coming, but in the meantime it's the same model as hashes in lock files.   

---

#### Should I commit my 'go.sum' file as well as my 'go.mod' file?
Typically your module's go.sum file should be committed along with your go.mod file.

go.sum contains the expected cryptographic checksums of the content of specific module versions.
If someone clones your repository and downloads your dependencies using the go command, they will receive an error if there is any mismatch between their downloaded copies of your dependencies and the corresponding entries in your go.sum.
In addition, go mod verify checks that the on-disk cached copies of module downloads still match the entries in go.sum.
Note that go.sum is not a lock file as used in some alternative dependency management systems. (go.mod provides enough information for reproducible builds).
See very brief rationale here from Filippo Valsorda on why you should check in your go.sum. See the "Module downloading and verification" section of the tip documentation for more details. See possible future extensions being discussed for example in #24117 and #25530.


### 参考
[Go 1.11 Modules](https://github.com/golang/go/wiki/Modules#should-i-commit-my-gosum-file-as-well-as-my-gomod-file)
