wget -NP . https://eichlerlab.gs.washington.edu/help/mvollger/share/wga_aln_plot/chm13.draft.v1.0.aln.bed.gz
wget -NP . https://s3.amazonaws.com/nanopore-human-wgs/chm13/assemblies/chm13.draft_v1.0.fasta.gz

gunzip chm13.draft_v1.0.fasta.gz
samtools faidx chm13.draft_v1.0.fasta

awk '{print $1 "\t" $2 }' chm13.draft_v1.0.fasta.fai \
            > chm13.draft_v1.0.chrom.sizes

gzcat chm13.draft.v1.0.aln.bed.gz | tail -n +2 |  cooler cload pairs -c1 1 -p1 2 -c2 4 -p2 5 \
            --field count=7:agg=mean,dtype=float \
            --chunksize 50000000000 \
            chm13.draft_v1.0.chrom.sizes:5000 \
	    --zero-based \
            - out.cool

cooler zoomify --field count:agg=mean,dtype=float out.cool
mv out.mcool chm13.draft_v1.0.draft.selfmap.5k.mcool
