#' @export
CorrScatterPlot <- function (mEQTL,threshold,expr,genot,visual=TRUE,cis=TRUE,filename='')
{
  # Inputs:
  #   mEQTL     - Matrix EQTL object with the eQTLs already collected
  #   threshold - FDR cutoff, only those eQTLs with equal or lower threshold will be taken into account
  #   expr      - Transcript expression dataset
  #   genot     - Genotyping dataset, either phased or unphased variants
  #   cis       - If TRUE only cis eQTLs are considered, otherwise trans eQTLS (default TRUE)
  #   visual    - If TRUE the script will display a box plot figure for each eQTL above the threshold
  #
  # Output: A vector with Pearson correlation scores for each eQTL that surpasses the given threshold
  #
  # NOTES:
  # Obviously the original files from which mEQTL object was computed must match on transcript, variants
  # and samples IDs included in expr and genot 
  #
  # expr and genot datafiles are in the matrixEQTL format and can be loaded as:
  # expr = read.table(file_name, header = TRUE, stringsAsFactors = FALSE);
  #
  # R. Armananzas - Last update 12/02/13
  #
  # For ZF need to set row.names=1 when reading genot and expr in
  
  
  corr  <- NULL; phenotype <- NULL; genotype <- NULL
  
  if (cis==TRUE)
  {
    index <- which(mEQTL$cis$eqtls$FDR<=threshold)
    eqtls <- mEQTL$cis$eqtls[index,]
  }
  else
  {
    index <- which(mEQTL$trans$eqtls$FDR<=threshold)
    eqtls <- mEQTL$trans$eqtls[index,]    
  }
  
  for (i in 1:nrow(eqtls))
  {
    phenotype[[i]] <- expr[which(rownames(expr)==as.character(eqtls$gene[i])),2:ncol(expr)]
    genotype[[i]]  <- genot[which(rownames(genot)==as.character(eqtls$snps[i])),2:ncol(genot)]
    corr[i]   <- cor(as.numeric(phenotype[[i]]),as.numeric(genotype[[i]]))
  }
  
  if (visual)
  {
	pdf(filename);
	par(mfcol = c(2, 2))
    for (i in 1:nrow(eqtls))
    {
      #Prepare the matrix
      geno <- as.numeric(genotype[[i]])
      pheno <- as.numeric(phenotype[[i]])

      plot(geno, pheno, xlab=paste(as.character(eqtls$snps[i]),"Expression",sep=" "), ylab=paste(as.character(eqtls$gene[i]), "Expression",sep=" "), ylim=c(min(pheno),max(pheno)+1), xlim=c(min(geno),max(geno)), main = paste(as.character(eqtls$snps[i])," - ",as.character(eqtls$gene[i]), "\nCorrelation: ",format(corr[i],2),"\nP-value: ",format(eqtls$pvalue[i],2),"\nFDR: ",format(eqtls$FDR[i],2)), cex.main=0.75)
      	      abline(lm(pheno ~ geno)) 
      
    }
        dev.off()
  }
  corr_file = paste("results/",substr(basename(filename), 1, nchar(basename(filename)) - 4),".corr",sep="");
  write.table(corr, corr_file, row.names=F,col.names=F);
  return(corr)
}
