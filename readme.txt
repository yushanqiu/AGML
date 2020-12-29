Package: AGML
Type: Package
Title: Adaptive graph-based multi-label learning for prediction of RNA-binding protein and alternative splicing event association during epithelial-mesenchymal transition
Version: 1.0
Author:Yushan Qiu<yushan.qiu@szu.edu.cn>
Maintainer: Yushan Qiu<yushan.qiu@szu.edu.cn>
Description: This package implements the AGML algorithm with a adaptively graph-based multi-label learning technique
		to predict novel RBP-AS event associations.
        
Depends:
    MATLAB (>= 2018a)
License: All source code is copyright, under the Artistic-2.0 License.
		For more information on Artistic-2.0 License see [http://opensource.org/licenses/Artistic-2.0](http://opensource.org/licenses/Artistic-2.0)
		
**Usage**

We provided a functions, case study for users. 
To run the case study, please load the script 'scorePrediction.m' into your MATLAB programming environment and click 'run'.



All the datasets used in the code, i.e. miRNA sequence similarity, miRNA functional similarity, miRNA semantic similarity, disease semantic similarity and miRNA-disease associations are all provided in the corresponding 'datasets/\*.mat'.



**Output**

The default output directory of AGML is under the same directory where the scripts locate and it can be changed in the 'caseStudy_RBP_AS.m'  file accordingly. All the results are stored in 'mat' file for convenience.

**Contact**

For any questions regarding our work, please feel free to contact us:yushan.qiu@szu.edu.cn.

 - If you have any problem, please contact Hao Jiang(jiangh@ruc.edu.cn) and Quan Zou (zouquan@nclab.edu.cn)!