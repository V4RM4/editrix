# frozen_string_literal: true

require_relative "editrix/version"
require 'json'

module Editrix
  class Error < StandardError; end

  class Parser
    def initialize(raw_271)
      @raw_271 = raw_271
    end

    def parse
      array_271 = @raw_271.split("~")    # Traversal array for split 271 segments
      @hash_271 = {}                     # Final hash for the entire decoded 271
      l_count = 0                       # Loop Segment counter
      dtp_count = 0                     # DTP segment counter
      ref_count = 0                     # REF segment counter
      hsd_count = 0                     # HSD segment counter
      per_count = 0                     # PER segment counter
      aaa_count = 0                     # AAA segment counter
      msg_count = 0                     # MSG segment counter
      trn_count = 0                     # TRN segment counter
      loop_secondary_count = 0          # loop counter

      loop_alpha = "@"
      loop_num = 2000
      ls_flag = false


      array_271.each do |each|             # Iterating through each 271 segment begins...

        # Declaration of individual segment hashes
        isa = {}
        gs  = {}
        st  = {}
        bht = {}
        hl  = {}
        trn = {}
        nm1 = {}
        n3  = {}
        n4  = {}
        dmg = {}
        ins = {}
        hi  = {}
        dtp = {}
        mpi = {}
        eb  = {}
        hsd = {}
        ref = {}
        per = {}
        aaa = {}
        prv = {}
        msg = {}
        iii = {}
        ls  = {}
        le  = {}
        se  = {}
        ge  = {}
        iea = {}


          # Hash for ISA - Interchange Control Header begins -----------------------------------------------------------------
        if each.start_with?("ISA")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            isa["ISA%02d" % i] = segment_values[i]
          end
          @hash_271["ISA"] = isa
          # Hash for ISA - Interchange Control Header ends -------------------------------------------------------------------



          # Hash for GS - Functional Group Header begins ---------------------------------------------------------------------
        elsif each.start_with?("GS")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            gs["GS%02d" % i] = segment_values[i]
          end
          @hash_271["GS"] = gs
          # Hash for GS - Functional Group Header ends -----------------------------------------------------------------------



          # Hash for ST - Transaction Set Header begins ----------------------------------------------------------------------
        elsif each.start_with?("ST")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            st["ST%02d" % i] = segment_values[i]
          end
          @hash_271["ST"] = st
          # Hash for ST - Transaction Set Header ends ------------------------------------------------------------------------



          # Hash for BHT - Beginning Of Hierarchical Transaction begins ------------------------------------------------------
        elsif each.start_with?("BHT")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            bht["BHT%02d" % i] = segment_values[i]
          end
          @hash_271["BHT"] = bht
          # Hash for BHT - Beginning Of Hierarchical Transaction ends --------------------------------------------------------



          # Hash for HL - Hierarchical Level begins --------------------------------------------------------------------------
        elsif each.start_with?("HL")
          loop_num = 2000
          loop_alpha.next!
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            hl["HL%02d" % i] = segment_values[i]
          end
          @hash_271["#{loop_num.to_s+loop_alpha}.HL"] = hl
          # Hash for HL - Hierarchical Level ends ----------------------------------------------------------------------------



          # Hash for TRN - Trace begins --------------------------------------------------------------------------------------
        elsif each.start_with?("TRN")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            trn["TRN%02d" % i] = segment_values[i]
          end
          trn_count += 1
          @hash_271["#{loop_num.to_s+loop_alpha}.TRN#{trn_count}"] = trn
          # Hash for TRN - Trace ends ----------------------------------------------------------------------------------------



          # Hash for NM1 - Individual or Organization Name begins ------------------------------------------------------------
        elsif each.start_with?("NM1")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            nm1["NM1%02d" % i] = segment_values[i]
          end
          loop_num == 2100
          if ls_flag == true
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.2120C#{l_count}.NM1"] = nm1
          else
            @hash_271["#{loop_num.to_s+loop_alpha}.NM1"] = nm1
          end
          # loop_secondary_count = 0
          # Hash for NM1 - Individual or Organization Name ends --------------------------------------------------------------



          # Hash for N3 - Party Location begins ------------------------------------------------------------------------------
        elsif each.start_with?("N3")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            n3["N3%02d" % i] = segment_values[i]
          end
          if ls_flag == true
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.2120C#{l_count}.N3"] = n3
          else
            @hash_271["#{loop_num.to_s+loop_alpha}.N3"] = n3
          end

          # Hash for N3 - Party Location ends --------------------------------------------------------------------------------



          # Hash for N4 - Geographic Location begins -------------------------------------------------------------------------
        elsif each.start_with?("N4")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            n4["N4%02d" % i] = segment_values[i]
          end
          if l_count != 0
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.2120C#{l_count}.N4"] = n4
          else
            @hash_271["#{loop_num.to_s+loop_alpha}.N4"] = n4
          end

          # Hash for N4 - Geographic Location ends ---------------------------------------------------------------------------



          # Hash for DMG - Demographic Information begins --------------------------------------------------------------------
        elsif each.start_with?("DMG")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            dmg["DMG%02d" % i] = segment_values[i]
          end
          @hash_271["#{loop_num.to_s+loop_alpha}.DMG"] = dmg
          # Hash for DMG - Demographic Information ends ----------------------------------------------------------------------



          # Hash for INS - Insured Benefit begins ----------------------------------------------------------------------------
        elsif each.start_with?("INS")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            ins["INS%02d" % i] = segment_values[i]
          end
          @hash_271["#{loop_num.to_s+loop_alpha}.INS"] = ins
          # Hash for INS - Insured Benefit ends ------------------------------------------------------------------------------



          # Hash for HI - Healthcare Information codes begin -----------------------------------------------------------------
        elsif each.start_with?("HI")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            hi["HI%02d" % i] = segment_values[i]
          end
          @hash_271["#{loop_num.to_s+loop_alpha}.HI"] = hi
          # Hash for HI - Healthcare Information codes end -------------------------------------------------------------------



          # Hash for DTP - Date or Time or Period begins ---------------------------------------------------------------------
        elsif each.start_with?("DTP")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            dtp["DTP%02d" % i] = segment_values[i]
          end
          dtp_count += 1
          if loop_secondary_count != 0
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.DTP#{dtp_count}"] = dtp
          else
            @hash_271["#{loop_num.to_s+loop_alpha}.DTP#{dtp_count}"] = dtp
          end
          # Hash for DTP - Date or Time or Period ends -----------------------------------------------------------------------



          # Hash for MPI - Military Personnel Information begins -------------------------------------------------------------
        elsif each.start_with?("MPI")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            mpi["MPI%02d" % i] = segment_values[i]
          end
          @hash_271["#{loop_num.to_s+loop_alpha}.MPI"] = mpi
          # Hash for MPI - Military Personnel Information ends ---------------------------------------------------------------



          # Hash for EB - Eligibility or Benefit Information Begins ----------------------------------------------------------
        elsif each.start_with?("EB")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            eb["EB%02d" % i] = segment_values[i]
          end
          loop_num = 2110
          loop_secondary_count += 1
          @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.EB"] = eb

          # Resetting counter variable for each eligibility loop
          dtp_count = 0
          hsd_count = 0
          ref_count = 0
          aaa_count = 0
          msg_count = 0
          per_count = 0
          l_count = 0
          # Hash for EB - Eligibility or Benefit Information ends ------------------------------------------------------------



          # Hash for HSD - Healthcare Services Delivery begins ---------------------------------------------------------------
        elsif each.start_with?("HSD")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            hsd["HSD%02d" % i] = segment_values[i]
          end
          hsd_count += 1
          @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.HSD#{hsd_count}"] = hsd
          # Hash for HSD - Healthcare Services Delivery ends -----------------------------------------------------------------



          # Hash for REF - Reference Information begins ----------------------------------------------------------------------
        elsif each.start_with?("REF")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            ref["REF%02d" % i] = segment_values[i]
          end
          ref_count += 1
          if loop_secondary_count != 0
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.REF#{ref_count}"] = ref
          else
            @hash_271["#{loop_num.to_s+loop_alpha}.REF#{ref_count}"] = ref
          end
          # Hash for REF - Reference Information ends ------------------------------------------------------------------------



          # Hash for PER - Administrative Communications Contact begins ------------------------------------------------------
        elsif each.start_with?("PER")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            per["PER%02d" % i] = segment_values[i]
          end
          per_count += 1
          if ls_flag == true
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.2120C#{l_count}.PER#{per_count}"] = per
          else
            @hash_271["#{loop_num.to_s+loop_alpha}.PER#{per_count}"] = per
          end
          # Hash for PER - Administrative Communications Contact ends --------------------------------------------------------



          # Hash for AAA - Request Validation begins -------------------------------------------------------------------------
        elsif each.start_with?("AAA")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            aaa["AAA%02d" % i] = segment_values[i]
          end
          aaa_count += 1
          if loop_secondary_count != 0
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.AAA#{aaa_count}"] = aaa
          else
            @hash_271["#{loop_num.to_s+loop_alpha}.AAA#{aaa_count}"] = aaa
          end
          # Hash for AAA - Request Validation ends ---------------------------------------------------------------------------


          # Hash for PRV - Provider Information begins -----------------------------------------------------------------------
        elsif each.start_with?("PRV")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            prv["PRV%02d" % i] = segment_values[i]
          end
          if ls_flag == true
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.2120C#{l_count}.PRV"] = prv
          else
            if loop_secondary_count != 0
              @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.PRV"] = prv
            else
              @hash_271["#{loop_num.to_s+loop_alpha}.PRV"] = prv
            end
          end
          # Hash for PRV - Provider Information ends -------------------------------------------------------------------------



          # Hash for MSG - Message Text begins -------------------------------------------------------------------------------
        elsif each.start_with?("MSG")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            msg["MSG%02d" % i] = segment_values[i]
          end
          msg_count += 1
          @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.MSG#{msg_count}"] = msg
          # Hash for MSG - Message Text ends ---------------------------------------------------------------------------------



          # Hash for III - Information begins --------------------------------------------------------------------------------
        elsif each.start_with?("III")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            iii["III%02d" % i] = segment_values[i]
          end
          if l_count != 0
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.2115C.III#{l_count}"] = iii
          else
            @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.2115C.III"] = iii
          end
          # Hash for III - Information ends ----------------------------------------------------------------------------------



          # Hash for LS - Loop Header begins ---------------------------------------------------------------------------------
        elsif each.start_with?("LS")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            ls["LS%02d" % i] = segment_values[i]
          end
          l_count += 1
          @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.LS#{l_count}"] = ls
          ls_flag = true
          # Hash for LS - Loop Header ends -----------------------------------------------------------------------------------



          # Hash for LE - Loop Trailer begins --------------------------------------------------------------------------------
        elsif each.start_with?("LE")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            le["LE%02d" % i] = segment_values[i]
          end
          @hash_271["#{loop_num.to_s+loop_alpha}.#{loop_secondary_count}.LE#{l_count}"] = le
          ls_flag = false
          # Hash for LE - Loop Trailer ends ----------------------------------------------------------------------------------



          # Hash for SE - Transaction Set Trailer begins ---------------------------------------------------------------------
        elsif each.start_with?("SE")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            se["SE%02d" % i] = segment_values[i]
          end
          @hash_271["SE"] = se
          # Hash for SE - Transaction Set Trailer ends -----------------------------------------------------------------------



          # Hash for GE - Functional Group Trailer begins --------------------------------------------------------------------
        elsif each.start_with?("GE")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            ge["GE%02d" % i] = segment_values[i]
          end
          @hash_271["GE"] = ge
          # Hash for GE - Functional Group Trailer ends ----------------------------------------------------------------------



          # Hash for IEA - Interchange Control Trailer begins ----------------------------------------------------------------
        elsif each.start_with?("IEA")
          segment_values = each.split("*")
          (1..segment_values.length-1).each do |i|
            iea["IEA%02d" % i] = segment_values[i]
          end
          @hash_271["IEA"] = iea
          # Hash for IEA - Interchange Control Trailer ends ------------------------------------------------------------------
        end
        end   #---------------------------------------- Iterating through each 271 segment ends...
    end

    def result
      @hash_271
    end

    def prettyResult
      JSON.generate(@hash_271)
    end
  end #End of class

end
