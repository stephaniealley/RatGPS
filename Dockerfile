FROM mdabioinfo/sos-notebook@sha256:4e085e56d81cef438b6909bf41ec192d5781c20f80b2a7b716a48e2f89f25d82

RUN cd ~;\
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh;\
    bash ~/miniconda.sh -b -p $HOME/miniconda;\
    echo ". ~/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc;\
    source ~/.bashrc;\
    pip install yes;
    yes | conda create -n py27 python=2.7;\
    source activate py27;\
    conda install notebook ipykerne matplotlib numpyl;\
    ipython kernel install --user;\
    source deactivate;\
    yes |conda create -n py36 python=3.6;\
    source activate py36;\
    conda install notebook ipykernel;\
    ipython kernel install --user;\
    source deactivate;\
    cd $HOME/work;\
    git clone --single-branch -b master https://github.com/mathieuboudreau/RatGPS.git; \
    cd RatGPS;\

    pip install matplotlib; \
    source activate ipykernel_py2; \
    pip install matplotlib; \
    source deactivate; \
    chmod -R 777 $HOME/work/RatGPS
    
WORKDIR $HOME/work/RatGPS

USER $NB_UID

# Specify the default command to run
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
