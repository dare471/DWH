select
RBX.�����������,o.description
,DATEADD(yy, DATEDIFF(yy, 0, [������]) , 0)[������]
,dateadd(day,1,EOMONTH(RBX.������,-1)) �����
,sum((Case when ������='5710' and ������ in ('6010','6020','6030') then RBX.����� else 0 end))-sum((Case when ������ in('6010','6020','6030') and ������='5710'then RBX.����� else 0 end)) as [�������]
--,sum((Case when ������='5710' and ������ in('7010') then r.����� else 0 end))-sum((Case when ������='5710' and  ������ in ('7010') then r.����� else 0 end)) as [������������� ������������� �������]
--,sum((Case when ������='5710' and ������ in('7210','7212') then r.����� else 0 end))-sum((Case when ������='5710' and  ������ in ('7210','7212') then r.����� else 0 end)) as [����� � ���������������� �������]
--,sum((Case when ������='5710' and ������ in('6280','7440') then r.����� else 0 end))-sum((Case when ������='5710' and  ������ in ('6280','7440') then r.����� else 0 end)) as [��������� � ��� �� �������� ����������� �������������]
--,sum((Case when ������='5710' and ������ in('7110') then r.����� else 0 end))-sum((Case when ������='5710' and  ������ in ('7110') then r.����� else 0 end)) as[������� �� ����������]
--,sum((Case when ������='5710' and ������ in ('6210','6230','6290')then r.����� else 0 end))-sum((Case when ������ in('6210','6230','6290') and ������='5710' then r.����� else 0 end)) as [������ ������]
--,sum((Case when ������='5710' and ������ in('7410','7480') then r.����� else 0 end))-sum((Case when ������='5710' and  ������ in ('7410','7480') then r.����� else 0 end)) as [������ �������]
--,sum((Case when ������='5710' and ������ in ('6110')then r.����� else 0 end))-sum((Case when ������ in('6110') and ������='5710' then r.����� else 0 end)) as [���������� ������]
--,sum((Case when ������='5710' and ������ in('7310','7340') then r.����� else 0 end))-sum((Case when ������='5710' and  ������ in ('7310','7340') then r.����� else 0 end)) as [������� �� ��������������]
--,sum((Case when ������='5710' and ������ in('6250','7430') then r.����� else 0 end))-sum((Case when ������='5710' and  ������ in ('6250','7430') then r.����� else 0 end)) as [�������� �������]
--,sum((Case when ������='5710' and ������ in('7710') then r.����� else 0 end))-sum((Case when ������='5710' and  ������ in ('7710') then r.����� else 0 end)) as [������� �� ������ �� �������]

--,sum(Case when ������ in ('1030','1010','1050','1021','1022','1090','1151') then r.����� else 0 end)-sum(Case when ������ in('1030','1010','1050','1021','1022','1090','1151') then r.����� else 0 end) as [�������� ��������]
--,sum((Case when ������ in ('1710') then r.����� else 0 end))-sum((Case when ������ in('1710') then r.����� else 0 end)) as [������ �������� �����������]
--,sum((Case when ������ in('3510') then r.����� else 0 end))-sum((Case when ������ in ('3510') then r.����� else 0 end)) as [������ ���������� �� ��������]
--,sum((Case when ������ in('4010') then r.����� else 0 end))-sum((Case when ������ in ('4010') then r.����� else 0 end)) as [������������ ������� � �����]
--,sum((Case when ������ in ('2210.1') then r.����� else 0 end))-sum((Case when ������ in('2210.1') then r.����� else 0 end)) as [������������ ���������� �������� (����������)]
--,sum((Case when ������ in ('1210','1280') then r.����� else 0 end))-sum((Case when ������ in('1210','1280') then r.����� else 0 end)) as [������������� ��������]
--,sum((Case when ������ in('3310') then r.����� else 0 end))-sum((Case when ������ in ('3310') then r.����� else 0 end)) as [������������� ����� ������������]
--,sum((Case when ������ in ('1254') then r.����� else 0 end))-sum((Case when ������ in('1254') then r.����� else 0 end)) as [����� ����������]
--,case when(sum((Case when ������ in ('1410','3110') then r.����� else 0 end))-sum((Case when ������ in('1410','3110') then r.����� else 0 end)))>0 then sum((Case when ������ in ('1410','3110') then r.����� else 0 end))-sum((Case when ������ in('1410','3110') then r.����� else 0 end)) else 0 end as [���]
--,case when(sum((Case when ������ in('1410','3110') then r.����� else 0 end))-sum((Case when ������ in ('1410','3110') then r.����� else 0 end)))>0 then sum((Case when ������ in('1410','3110') then r.����� else 0 end))-sum((Case when ������ in ('1410','3110') then r.����� else 0 end))else 0 end as [��� �������������]
--,sum((Case when ������ in('3010') then r.����� else 0 end))-sum((Case when ������ in ('3010') then r.����� else 0 end)) as [������������� ������� � �����]
--,sum((Case when ������ in ('1310') then r.����� else 0 end))-sum((Case when ������ in ('1310') then r.����� else 0 end)) as [���������]
--,case when (sum((Case when ������ in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.����� else 0 end))-sum((Case when ������ in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.����� else 0 end)))>0 
--then sum((Case when ������ in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.����� else 0 end))-sum((Case when ������ in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.����� else 0 end)) else 0 end as [���]
--,case when (sum((Case when ������ in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.����� else 0 end))-sum((Case when ������ in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.����� else 0 end)))>0
--then sum((Case when ������ in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.����� else 0 end))-sum((Case when ������ in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.����� else 0 end)) else 0 end as [��� �������������]
--,sum((Case when ������ in ('2730','2740') then r.����� else 0 end))-sum((Case when ������ in('2730','2740') then r.����� else 0 end)) as [�������������� ������]
--,sum((Case when ������ in('5610','5620','5710') then r.����� else 0 end))-sum((Case when ������ in ('5610','5620','5710') then r.����� else 0 end)) as [���������������� �������]
--,sum((Case when ������ in('3040') then r.����� else 0 end))-sum((Case when ������ in ('3040') then r.����� else 0 end)) as [������������� �� ����������]
--,sum((Case when ������ in('3350','3385','3430') then r.����� else 0 end))-sum((Case when ������ in ('3350','3385','3430') then r.����� else 0 end)) as [������������� �� ���������� �����]
--,sum((Case when ������ in ('2411','2412','2421') then r.����� else 0 end))-sum((Case when ������ in('2411','2412','2421') then r.����� else 0 end)) as [�������� ��������]
--,sum((Case when ������ in ('2810') then r.����� else 0 end))-sum((Case when ������ in('2810') then r.����� else 0 end)) as [���������� ��������� ������]
--,sum((Case when ������ in ('1251') then r.����� else 0 end))-sum((Case when ������ in('1251') then r.����� else 0 end)) as [������������]
--,sum((Case when ������ in ('2442','2451') then r.����� else 0 end))-sum((Case when ������ in('2442','2451') then r.����� else 0 end)) as [������ ������������ ������]
--,sum((Case when ������ in('4150') then r.����� else 0 end))-sum((Case when ������ in ('4150') then r.����� else 0 end)) as [������ ������������ �������������]
--,sum((Case when ������ in ('1220','1253','1274','1720','1740') then r.����� else 0 end))-sum((Case when ������ in('1220','1253','1274','1720','1740') then r.����� else 0 end)) as [������ ������������� ������]
--,sum((Case when ������ in('0000','3050','3080','3382','3388.1') then r.����� else 0 end))-sum((Case when ������ in ('0000','3050','3080','3382','3388.1') then r.����� else 0 end)) as [������ ������������� �������������]
--,sum((Case when ������ in ('1430') then r.����� else 0 end))-sum((Case when ������ in('1430') then r.����� else 0 end)) as [������ ������]
--,sum((Case when ������ in('3120','3150','3160','3170','3180','3190','3211','3212','3213','3221','3230') then r.����� else 0 end))
--                       -sum((Case when ������ in ('3120','3150','3160','3170','3180','3190','3211','3212','3213','3221','3230') then r.����� else 0 end)) as [������ ������ (����)]
--,sum((Case when ������ in ('1330','1363') then r.����� else 0 end))-sum((Case when ������ in('1330','1363') then r.����� else 0 end)) as [������]
--,sum((Case when ������ in('5110','5030') then r.����� else 0 end))-sum((Case when ������ in ('5110','5030') then r.����� else 0 end)) as [�������� �������]


from  [AA_DWH].[dbo].[������������������.������������] RBX
  left join AA_DWH.dbo.����������� o on o.guid=RBX.�����������
  left join AA_DWH.dbo.�������������������� p on p.guid=RBX.���������������
  left join AA_DWH.dbo.�������������������� p2 on p2.guid=RBX.���������������
  WHERE 1=1
 AND o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								)  

  group by o.description,RBX.�����������
,DATEADD(yy, DATEDIFF(yy, 0, [������]) , 0)
,dateadd(day,1,EOMONTH(RBX.������,-1))
  order by dateadd(day,1,EOMONTH(RBX.������,-1)), ������,�����������



--  13220233730.07
--0.00
--0.00
--0.00
--432922285.71
--0.00
--22564797.41