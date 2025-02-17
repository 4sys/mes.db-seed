PGDMP  ;    %                 }            mes-db    16.1 (Debian 16.1-1.pgdg120+1)    16.0 �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    609429    mes-db    DATABASE     s   CREATE DATABASE "mes-db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE "mes-db";
                postgres    false                        2615    609430    doc    SCHEMA        CREATE SCHEMA doc;
    DROP SCHEMA doc;
                postgres    false            �           0    0 
   SCHEMA doc    ACL     #   GRANT ALL ON SCHEMA doc TO PUBLIC;
                   postgres    false    6                        2615    609431    es    SCHEMA        CREATE SCHEMA es;
    DROP SCHEMA es;
                postgres    false            �           0    0 	   SCHEMA es    ACL     "   GRANT ALL ON SCHEMA es TO PUBLIC;
                   postgres    false    7            $           1255    609438    mt_grams_array(text)    FUNCTION     /  CREATE FUNCTION doc.mt_grams_array(words text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
        DECLARE
result text[];
        DECLARE
word text;
        DECLARE
clean_word text;
BEGIN
                FOREACH
word IN ARRAY string_to_array(words, ' ')
                LOOP
                     clean_word = regexp_replace(word, '[^a-zA-Z0-9]+', '','g');
FOR i IN 1 .. length(clean_word)
                     LOOP
                         result := result || quote_literal(substr(lower(clean_word), i, 1));
                         result
:= result || quote_literal(substr(lower(clean_word), i, 2));
                         result
:= result || quote_literal(substr(lower(clean_word), i, 3));
END LOOP;
END LOOP;

RETURN ARRAY(SELECT DISTINCT e FROM unnest(result) AS a(e) ORDER BY e);
END;
$$;
 .   DROP FUNCTION doc.mt_grams_array(words text);
       doc          postgres    false    6            �           1255    609437    mt_grams_query(text)    FUNCTION     �   CREATE FUNCTION doc.mt_grams_query(text) RETURNS tsquery
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
BEGIN
RETURN (SELECT array_to_string(doc.mt_grams_array($1), ' & ') ::tsquery);
END
$_$;
 (   DROP FUNCTION doc.mt_grams_query(text);
       doc          postgres    false    6            �           1255    609436    mt_grams_vector(text)    FUNCTION     �   CREATE FUNCTION doc.mt_grams_vector(text) RETURNS tsvector
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
BEGIN
RETURN (SELECT array_to_string(doc.mt_grams_array($1), ' ') ::tsvector);
END
$_$;
 )   DROP FUNCTION doc.mt_grams_vector(text);
       doc          postgres    false    6            �           1255    609435    mt_immutable_date(text)    FUNCTION     |   CREATE FUNCTION doc.mt_immutable_date(value text) RETURNS date
    LANGUAGE sql IMMUTABLE
    AS $$
select value::date

$$;
 1   DROP FUNCTION doc.mt_immutable_date(value text);
       doc          postgres    false    6            a           1255    609434    mt_immutable_time(text)    FUNCTION     �   CREATE FUNCTION doc.mt_immutable_time(value text) RETURNS time without time zone
    LANGUAGE sql IMMUTABLE
    AS $$
select value::time

$$;
 1   DROP FUNCTION doc.mt_immutable_time(value text);
       doc          postgres    false    6            �           1255    609432    mt_immutable_timestamp(text)    FUNCTION     �   CREATE FUNCTION doc.mt_immutable_timestamp(value text) RETURNS timestamp without time zone
    LANGUAGE sql IMMUTABLE
    AS $$
select value::timestamp

$$;
 6   DROP FUNCTION doc.mt_immutable_timestamp(value text);
       doc          postgres    false    6            �           1255    609433    mt_immutable_timestamptz(text)    FUNCTION     �   CREATE FUNCTION doc.mt_immutable_timestamptz(value text) RETURNS timestamp with time zone
    LANGUAGE sql IMMUTABLE
    AS $$
select value::timestamptz

$$;
 8   DROP FUNCTION doc.mt_immutable_timestamptz(value text);
       doc          postgres    false    6            �           1255    609616 S   mt_insert_embedexternalpagemodel(jsonb, character varying, character varying, uuid)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_embedexternalpagemodel(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_embedexternalpagemodel ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp());

  RETURN docVersion;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_embedexternalpagemodel(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            �           1255    609706 d   mt_insert_managementdashboardpanelpositiondetails(jsonb, character varying, character varying, uuid)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_managementdashboardpanelpositiondetails(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_managementdashboardpanelpositiondetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp());

  RETURN docVersion;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_managementdashboardpanelpositiondetails(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            ~           1255    609459 X   mt_insert_readmodels_actiondetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_actiondetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_actiondetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_actiondetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609472 \   mt_insert_readmodels_attendancehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_attendancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_attendancehistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_attendancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609485 Z   mt_insert_readmodels_buildingdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_buildingdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_buildingdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_buildingdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609498 \   mt_insert_readmodels_currentattendance(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_currentattendance(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_currentattendance ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_currentattendance(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            =           1255    609513 c   mt_insert_readmodels_currentemployeeexecution(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_currentemployeeexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_currentemployeeexecution ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_currentemployeeexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609526 j   mt_insert_readmodels_currentreportedquantityconsumed(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_currentreportedquantityconsumed(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_currentreportedquantityconsumed ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_currentreportedquantityconsumed(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609539 j   mt_insert_readmodels_currentreportedquantityproduced(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_currentreportedquantityproduced(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_currentreportedquantityproduced ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_currentreportedquantityproduced(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            ;           1255    609552 _   mt_insert_readmodels_currentresourcestate(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_currentresourcestate(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_currentresourcestate ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_currentresourcestate(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            9           1255    609565 a   mt_insert_readmodels_currentshiftsettlement(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_currentshiftsettlement(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_currentshiftsettlement ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_currentshiftsettlement(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609578 b   mt_insert_readmodels_currentworkcenterstatus(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_currentworkcenterstatus(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_currentworkcenterstatus ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_currentworkcenterstatus(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609591 d   mt_insert_readmodels_currentworkorderexecution(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_currentworkorderexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_currentworkorderexecution ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_currentworkorderexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609628 Z   mt_insert_readmodels_employeedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_employeedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_employeedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_employeedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609641 c   mt_insert_readmodels_employeeexecutionhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_employeeexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_employeeexecutionhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_employeeexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609654 `   mt_insert_readmodels_executionstatedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_executionstatedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_executionstatedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_executionstatedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609667 [   mt_insert_readmodels_executionsummary(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_executionsummary(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_executionsummary ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_executionsummary(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            U           1255    609680 Y   mt_insert_readmodels_factorydetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_factorydetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_factorydetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_factorydetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            <           1255    609693 W   mt_insert_readmodels_floordetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_floordetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_floordetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_floordetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            8           1255    609718 ^   mt_insert_readmodels_organizationdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_organizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_organizationdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_organizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609731 j   mt_insert_readmodels_reportedquantityconsumedhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_reportedquantityconsumedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_reportedquantityconsumedhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_reportedquantityconsumedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609744 j   mt_insert_readmodels_reportedquantityproducedhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_reportedquantityproducedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_reportedquantityproducedhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_reportedquantityproducedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609757 Z   mt_insert_readmodels_resourcedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_resourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_resourcedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_resourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            p           1255    609770 _   mt_insert_readmodels_resourcestatehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_resourcestatehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_resourcestatehistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_resourcestatehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609783 k   mt_insert_readmodels_shiftsettlementacceptancehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_shiftsettlementacceptancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_shiftsettlementacceptancehistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_shiftsettlementacceptancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            h           1255    609796 a   mt_insert_readmodels_shiftsettlementhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_shiftsettlementhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_shiftsettlementhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_shiftsettlementhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            0           1255    609809 V   mt_insert_readmodels_shiftsystem(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_shiftsystem(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_shiftsystem ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_shiftsystem(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609822 Z   mt_insert_readmodels_terminaldetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_terminaldetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_terminaldetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_terminaldetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            7           1255    609835 e   mt_insert_readmodels_typeoffinishedgoodsdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_typeoffinishedgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_typeoffinishedgoodsdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_typeoffinishedgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            r           1255    609848 Y   mt_insert_readmodels_userconfiguration(jsonb, character varying, character varying, uuid)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_userconfiguration(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_userconfiguration ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp());

  RETURN docVersion;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_userconfiguration(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6                       1255    609860 V   mt_insert_readmodels_userdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_userdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_userdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_userdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            o           1255    609873 ^   mt_insert_readmodels_userlocalizationfilter(jsonb, character varying, character varying, uuid)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_userlocalizationfilter(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_userlocalizationfilter ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp());

  RETURN docVersion;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_userlocalizationfilter(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            �           1255    609885 [   mt_insert_readmodels_usertokendetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_usertokendetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_usertokendetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_usertokendetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609898 \   mt_insert_readmodels_workcenterdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workcenterdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workcenterdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workcenterdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609911 d   mt_insert_readmodels_workcenterresourcedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workcenterresourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workcenterresourcedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workcenterresourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609924 Z   mt_insert_readmodels_workcenterstate(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workcenterstate(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workcenterstate ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workcenterstate(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            t           1255    609937 b   mt_insert_readmodels_workcenterstatushistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workcenterstatushistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workcenterstatushistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workcenterstatushistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609950 c   mt_insert_readmodels_workcentertoresourcebond(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workcentertoresourcebond(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workcentertoresourcebond ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workcentertoresourcebond(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609963 ^   mt_insert_readmodels_workorderbomdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderbomdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderbomdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderbomdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609976 [   mt_insert_readmodels_workorderdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609989 d   mt_insert_readmodels_workorderexecutionhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderexecutionhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            4           1255    610002 i   mt_insert_readmodels_workorderexecutionresourcelink(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderexecutionresourcelink(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderexecutionresourcelink ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderexecutionresourcelink(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            N           1255    610015 f   mt_insert_readmodels_workorderfinishgoodsdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderfinishgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderfinishgoodsdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderfinishgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610028 ^   mt_insert_readmodels_workorderjobdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderjobdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderjobdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderjobdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            s           1255    610041 b   mt_insert_readmodels_workorderjobnotedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderjobnotedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderjobnotedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderjobnotedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610054 \   mt_insert_readmodels_workorderjobstodo(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderjobstodo(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderjobstodo ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderjobstodo(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            3           1255    610067 f   mt_insert_readmodels_workorderpickinglistdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderpickinglistdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderpickinglistdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderpickinglistdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            J           1255    610080 f   mt_insert_readmodels_workorderrealizationdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_workorderrealizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_workorderrealizationdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_workorderrealizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            v           1255    610093 V   mt_insert_readmodels_zonedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_insert_readmodels_zonedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO doc.mt_doc_readmodels_zonedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp());
  RETURN 1;
END;
$$;
 �   DROP FUNCTION doc.mt_insert_readmodels_zonedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            !           1255    609439 .   mt_jsonb_append(jsonb, text[], jsonb, boolean)    FUNCTION     �  CREATE FUNCTION doc.mt_jsonb_append(jsonb, text[], jsonb, boolean) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
    retval ALIAS FOR $1;
    location ALIAS FOR $2;
    val ALIAS FOR $3;
    if_not_exists ALIAS FOR $4;
    tmp_value jsonb;
BEGIN
    tmp_value = retval #> location;
    IF tmp_value IS NOT NULL AND jsonb_typeof(tmp_value) = 'array' THEN
        CASE
            WHEN NOT if_not_exists THEN
                retval = jsonb_set(retval, location, tmp_value || val, FALSE);
            WHEN jsonb_typeof(val) = 'object' AND NOT tmp_value @> jsonb_build_array(val) THEN
                retval = jsonb_set(retval, location, tmp_value || val, FALSE);
            WHEN jsonb_typeof(val) <> 'object' AND NOT tmp_value @> val THEN
                retval = jsonb_set(retval, location, tmp_value || val, FALSE);
            ELSE NULL;
            END CASE;
    END IF;
    RETURN retval;
END;
$_$;
 B   DROP FUNCTION doc.mt_jsonb_append(jsonb, text[], jsonb, boolean);
       doc          postgres    false    6            �           1255    609440 $   mt_jsonb_copy(jsonb, text[], text[])    FUNCTION     �  CREATE FUNCTION doc.mt_jsonb_copy(jsonb, text[], text[]) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
    retval ALIAS FOR $1;
    src_path ALIAS FOR $2;
    dst_path ALIAS FOR $3;
    tmp_value jsonb;
BEGIN
    tmp_value = retval #> src_path;
    retval = doc.mt_jsonb_fix_null_parent(retval, dst_path);
    RETURN jsonb_set(retval, dst_path, tmp_value::jsonb, TRUE);
END;
$_$;
 8   DROP FUNCTION doc.mt_jsonb_copy(jsonb, text[], text[]);
       doc          postgres    false    6                        1255    609441 (   mt_jsonb_duplicate(jsonb, text[], jsonb)    FUNCTION     �  CREATE FUNCTION doc.mt_jsonb_duplicate(jsonb, text[], jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
    retval ALIAS FOR $1;
    location ALIAS FOR $2;
    targets ALIAS FOR $3;
    tmp_value jsonb;
    target_path text[];
    target text;
BEGIN
    FOR target IN SELECT jsonb_array_elements_text(targets)
    LOOP
        target_path = doc.mt_jsonb_path_to_array(target, '\.');
        retval = doc.mt_jsonb_copy(retval, location, target_path);
    END LOOP;

    RETURN retval;
END;
$_$;
 <   DROP FUNCTION doc.mt_jsonb_duplicate(jsonb, text[], jsonb);
       doc          postgres    false    6            �           1255    609442 '   mt_jsonb_fix_null_parent(jsonb, text[])    FUNCTION     �  CREATE FUNCTION doc.mt_jsonb_fix_null_parent(jsonb, text[]) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
retval ALIAS FOR $1;
    dst_path ALIAS FOR $2;
    dst_path_segment text[] = ARRAY[]::text[];
    dst_path_array_length integer;
    i integer = 1;
BEGIN
    dst_path_array_length = array_length(dst_path, 1);
    WHILE i <=(dst_path_array_length - 1)
    LOOP
        dst_path_segment = dst_path_segment || ARRAY[dst_path[i]];
        IF retval #> dst_path_segment = 'null'::jsonb THEN
            retval = jsonb_set(retval, dst_path_segment, '{}'::jsonb, TRUE);
        END IF;
        i = i + 1;
    END LOOP;

    RETURN retval;
END;
$_$;
 ;   DROP FUNCTION doc.mt_jsonb_fix_null_parent(jsonb, text[]);
       doc          postgres    false    6            G           1255    609443 *   mt_jsonb_increment(jsonb, text[], numeric)    FUNCTION     �  CREATE FUNCTION doc.mt_jsonb_increment(jsonb, text[], numeric) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
retval ALIAS FOR $1;
    location ALIAS FOR $2;
    increment_value ALIAS FOR $3;
    tmp_value jsonb;
BEGIN
    tmp_value = retval #> location;
    IF tmp_value IS NULL THEN
        tmp_value = to_jsonb(0);
END IF;

RETURN jsonb_set(retval, location, to_jsonb(tmp_value::numeric + increment_value), TRUE);
END;
$_$;
 >   DROP FUNCTION doc.mt_jsonb_increment(jsonb, text[], numeric);
       doc          postgres    false    6            L           1255    609444 7   mt_jsonb_insert(jsonb, text[], jsonb, integer, boolean)    FUNCTION     "  CREATE FUNCTION doc.mt_jsonb_insert(jsonb, text[], jsonb, integer, boolean) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
    retval ALIAS FOR $1;
    location ALIAS FOR $2;
    val ALIAS FOR $3;
    elm_index ALIAS FOR $4;
    if_not_exists ALIAS FOR $5;
    tmp_value jsonb;
BEGIN
    tmp_value = retval #> location;
    IF tmp_value IS NOT NULL AND jsonb_typeof(tmp_value) = 'array' THEN
        IF elm_index IS NULL THEN
            elm_index = jsonb_array_length(tmp_value) + 1;
        END IF;
        CASE
            WHEN NOT if_not_exists THEN
                retval = jsonb_insert(retval, location || elm_index::text, val);
            WHEN jsonb_typeof(val) = 'object' AND NOT tmp_value @> jsonb_build_array(val) THEN
                retval = jsonb_insert(retval, location || elm_index::text, val);
            WHEN jsonb_typeof(val) <> 'object' AND NOT tmp_value @> val THEN
                retval = jsonb_insert(retval, location || elm_index::text, val);
            ELSE NULL;
        END CASE;
    END IF;
    RETURN retval;
END;
$_$;
 K   DROP FUNCTION doc.mt_jsonb_insert(jsonb, text[], jsonb, integer, boolean);
       doc          postgres    false    6                       1255    609445 "   mt_jsonb_move(jsonb, text[], text)    FUNCTION     �  CREATE FUNCTION doc.mt_jsonb_move(jsonb, text[], text) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
    retval ALIAS FOR $1;
    src_path ALIAS FOR $2;
    dst_name ALIAS FOR $3;
    dst_path text[];
    tmp_value jsonb;
BEGIN
    tmp_value = retval #> src_path;
    retval = retval #- src_path;
    dst_path = src_path;
    dst_path[array_length(dst_path, 1)] = dst_name;
    retval = doc.mt_jsonb_fix_null_parent(retval, dst_path);
    RETURN jsonb_set(retval, dst_path, tmp_value, TRUE);
END;
$_$;
 6   DROP FUNCTION doc.mt_jsonb_move(jsonb, text[], text);
       doc          postgres    false    6                       1255    609448    mt_jsonb_patch(jsonb, jsonb)    FUNCTION     C  CREATE FUNCTION doc.mt_jsonb_patch(jsonb, jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
    retval ALIAS FOR $1;
    patchset ALIAS FOR $2;
    patch jsonb;
    patch_path text[];
    value jsonb;
BEGIN
    FOR patch IN SELECT * from jsonb_array_elements(patchset)
    LOOP
        patch_path = doc.mt_jsonb_path_to_array((patch->>'path')::text, '\.');

        CASE patch->>'type'
            WHEN 'set' THEN
                retval = jsonb_set(retval, patch_path,(patch->'value')::jsonb, TRUE);
        WHEN 'delete' THEN
                retval = retval#-patch_path;
        WHEN 'append' THEN
                retval = doc.mt_jsonb_append(retval, patch_path,(patch->'value')::jsonb, FALSE);
        WHEN 'append_if_not_exists' THEN
                retval = doc.mt_jsonb_append(retval, patch_path,(patch->'value')::jsonb, TRUE);
        WHEN 'insert' THEN
                retval = doc.mt_jsonb_insert(retval, patch_path,(patch->'value')::jsonb,(patch->>'index')::integer, FALSE);
        WHEN 'insert_if_not_exists' THEN
                retval = doc.mt_jsonb_insert(retval, patch_path,(patch->'value')::jsonb,(patch->>'index')::integer, TRUE);
        WHEN 'remove' THEN
                retval = doc.mt_jsonb_remove(retval, patch_path,(patch->'value')::jsonb);
        WHEN 'duplicate' THEN
                retval = doc.mt_jsonb_duplicate(retval, patch_path,(patch->'targets')::jsonb);
        WHEN 'rename' THEN
                retval = doc.mt_jsonb_move(retval, patch_path,(patch->>'to')::text);
        WHEN 'increment' THEN
                retval = doc.mt_jsonb_increment(retval, patch_path,(patch->>'increment')::numeric);
        WHEN 'increment_float' THEN
                retval = doc.mt_jsonb_increment(retval, patch_path,(patch->>'increment')::numeric);
        ELSE NULL;
        END CASE;
    END LOOP;
    RETURN retval;
END;
$_$;
 0   DROP FUNCTION doc.mt_jsonb_patch(jsonb, jsonb);
       doc          postgres    false    6            �           1255    609446 '   mt_jsonb_path_to_array(text, character)    FUNCTION     �   CREATE FUNCTION doc.mt_jsonb_path_to_array(text, character) RETURNS text[]
    LANGUAGE plpgsql
    AS $_$
DECLARE
    location ALIAS FOR $1;
    regex_pattern ALIAS FOR $2;
BEGIN
RETURN regexp_split_to_array(location, regex_pattern)::text[];
END;
$_$;
 ;   DROP FUNCTION doc.mt_jsonb_path_to_array(text, character);
       doc          postgres    false    6            �           1255    609447 %   mt_jsonb_remove(jsonb, text[], jsonb)    FUNCTION     e  CREATE FUNCTION doc.mt_jsonb_remove(jsonb, text[], jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
    retval ALIAS FOR $1;
    location ALIAS FOR $2;
    val ALIAS FOR $3;
    tmp_value jsonb;
BEGIN
    tmp_value = retval #> location;
    IF tmp_value IS NOT NULL AND jsonb_typeof(tmp_value) = 'array' THEN
        tmp_value =(SELECT jsonb_agg(elem)
        FROM jsonb_array_elements(tmp_value) AS elem
        WHERE elem <> val);

        IF tmp_value IS NULL THEN
            tmp_value = '[]'::jsonb;
        END IF;
    END IF;
    RETURN jsonb_set(retval, location, tmp_value, FALSE);
END;
$_$;
 9   DROP FUNCTION doc.mt_jsonb_remove(jsonb, text[], jsonb);
       doc          postgres    false    6            m           1255    609461 [   mt_overwrite_readmodels_actiondetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_actiondetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_actiondetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_actiondetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_actiondetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_actiondetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609474 _   mt_overwrite_readmodels_attendancehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_attendancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_attendancehistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_attendancehistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_attendancehistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_attendancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609487 ]   mt_overwrite_readmodels_buildingdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_buildingdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_buildingdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_buildingdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_buildingdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_buildingdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            x           1255    609500 _   mt_overwrite_readmodels_currentattendance(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_currentattendance(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentattendance into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_currentattendance ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_currentattendance into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_currentattendance(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609515 f   mt_overwrite_readmodels_currentemployeeexecution(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_currentemployeeexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentemployeeexecution into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_currentemployeeexecution ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_currentemployeeexecution into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_currentemployeeexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609528 m   mt_overwrite_readmodels_currentreportedquantityconsumed(jsonb, character varying, character varying, integer)    FUNCTION     !  CREATE FUNCTION doc.mt_overwrite_readmodels_currentreportedquantityconsumed(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentreportedquantityconsumed into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_currentreportedquantityconsumed ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_currentreportedquantityconsumed into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_currentreportedquantityconsumed(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609541 m   mt_overwrite_readmodels_currentreportedquantityproduced(jsonb, character varying, character varying, integer)    FUNCTION     !  CREATE FUNCTION doc.mt_overwrite_readmodels_currentreportedquantityproduced(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentreportedquantityproduced into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_currentreportedquantityproduced ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_currentreportedquantityproduced into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_currentreportedquantityproduced(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609554 b   mt_overwrite_readmodels_currentresourcestate(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_currentresourcestate(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentresourcestate into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_currentresourcestate ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_currentresourcestate into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_currentresourcestate(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609567 d   mt_overwrite_readmodels_currentshiftsettlement(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_currentshiftsettlement(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentshiftsettlement into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_currentshiftsettlement ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_currentshiftsettlement into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_currentshiftsettlement(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            M           1255    609580 e   mt_overwrite_readmodels_currentworkcenterstatus(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_currentworkcenterstatus(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentworkcenterstatus into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_currentworkcenterstatus ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_currentworkcenterstatus into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_currentworkcenterstatus(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609593 g   mt_overwrite_readmodels_currentworkorderexecution(jsonb, character varying, character varying, integer)    FUNCTION     	  CREATE FUNCTION doc.mt_overwrite_readmodels_currentworkorderexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentworkorderexecution into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_currentworkorderexecution ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_currentworkorderexecution into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_currentworkorderexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609630 ]   mt_overwrite_readmodels_employeedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_employeedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_employeedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_employeedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_employeedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_employeedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            n           1255    609643 f   mt_overwrite_readmodels_employeeexecutionhistory(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_employeeexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_employeeexecutionhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_employeeexecutionhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_employeeexecutionhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_employeeexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609656 c   mt_overwrite_readmodels_executionstatedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_executionstatedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_executionstatedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_executionstatedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_executionstatedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_executionstatedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            2           1255    609669 ^   mt_overwrite_readmodels_executionsummary(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_executionsummary(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_executionsummary into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_executionsummary ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_executionsummary into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_executionsummary(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609682 \   mt_overwrite_readmodels_factorydetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_factorydetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_factorydetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_factorydetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_factorydetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_factorydetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            -           1255    609695 Z   mt_overwrite_readmodels_floordetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_floordetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_floordetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_floordetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_floordetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_floordetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609720 a   mt_overwrite_readmodels_organizationdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_organizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_organizationdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_organizationdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_organizationdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_organizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            l           1255    609733 m   mt_overwrite_readmodels_reportedquantityconsumedhistory(jsonb, character varying, character varying, integer)    FUNCTION     !  CREATE FUNCTION doc.mt_overwrite_readmodels_reportedquantityconsumedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_reportedquantityconsumedhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_reportedquantityconsumedhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_reportedquantityconsumedhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_reportedquantityconsumedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609746 m   mt_overwrite_readmodels_reportedquantityproducedhistory(jsonb, character varying, character varying, integer)    FUNCTION     !  CREATE FUNCTION doc.mt_overwrite_readmodels_reportedquantityproducedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_reportedquantityproducedhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_reportedquantityproducedhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_reportedquantityproducedhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_reportedquantityproducedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609759 ]   mt_overwrite_readmodels_resourcedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_resourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_resourcedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_resourcedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_resourcedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_resourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609772 b   mt_overwrite_readmodels_resourcestatehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_resourcestatehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_resourcestatehistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_resourcestatehistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_resourcestatehistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_resourcestatehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            K           1255    609785 n   mt_overwrite_readmodels_shiftsettlementacceptancehistory(jsonb, character varying, character varying, integer)    FUNCTION     %  CREATE FUNCTION doc.mt_overwrite_readmodels_shiftsettlementacceptancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_shiftsettlementacceptancehistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_shiftsettlementacceptancehistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_shiftsettlementacceptancehistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_shiftsettlementacceptancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            &           1255    609798 d   mt_overwrite_readmodels_shiftsettlementhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_shiftsettlementhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_shiftsettlementhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_shiftsettlementhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_shiftsettlementhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_shiftsettlementhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609811 Y   mt_overwrite_readmodels_shiftsystem(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_shiftsystem(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_shiftsystem into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_shiftsystem ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_shiftsystem into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_shiftsystem(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609824 ]   mt_overwrite_readmodels_terminaldetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_terminaldetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_terminaldetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_terminaldetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_terminaldetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_terminaldetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            O           1255    609837 h   mt_overwrite_readmodels_typeoffinishedgoodsdetails(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_typeoffinishedgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_typeoffinishedgoodsdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_typeoffinishedgoodsdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_typeoffinishedgoodsdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_typeoffinishedgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            w           1255    609862 Y   mt_overwrite_readmodels_userdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_userdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_userdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_userdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_userdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_userdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609887 ^   mt_overwrite_readmodels_usertokendetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_usertokendetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_usertokendetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_usertokendetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_usertokendetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_usertokendetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            X           1255    609900 _   mt_overwrite_readmodels_workcenterdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_workcenterdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcenterdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workcenterdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workcenterdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workcenterdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609913 g   mt_overwrite_readmodels_workcenterresourcedetails(jsonb, character varying, character varying, integer)    FUNCTION     	  CREATE FUNCTION doc.mt_overwrite_readmodels_workcenterresourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcenterresourcedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workcenterresourcedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workcenterresourcedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workcenterresourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            C           1255    609926 ]   mt_overwrite_readmodels_workcenterstate(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_workcenterstate(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcenterstate into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workcenterstate ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workcenterstate into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workcenterstate(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            `           1255    609939 e   mt_overwrite_readmodels_workcenterstatushistory(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_workcenterstatushistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcenterstatushistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workcenterstatushistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workcenterstatushistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workcenterstatushistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609952 f   mt_overwrite_readmodels_workcentertoresourcebond(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_workcentertoresourcebond(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcentertoresourcebond into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workcentertoresourcebond ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workcentertoresourcebond into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workcentertoresourcebond(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609965 a   mt_overwrite_readmodels_workorderbomdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_workorderbomdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderbomdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderbomdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderbomdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderbomdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609978 ^   mt_overwrite_readmodels_workorderdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_workorderdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609991 g   mt_overwrite_readmodels_workorderexecutionhistory(jsonb, character varying, character varying, integer)    FUNCTION     	  CREATE FUNCTION doc.mt_overwrite_readmodels_workorderexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderexecutionhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderexecutionhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderexecutionhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            }           1255    610004 l   mt_overwrite_readmodels_workorderexecutionresourcelink(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_workorderexecutionresourcelink(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderexecutionresourcelink into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderexecutionresourcelink ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderexecutionresourcelink into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderexecutionresourcelink(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610017 i   mt_overwrite_readmodels_workorderfinishgoodsdetails(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_workorderfinishgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderfinishgoodsdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderfinishgoodsdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderfinishgoodsdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderfinishgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610030 a   mt_overwrite_readmodels_workorderjobdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_workorderjobdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderjobdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderjobdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            (           1255    610043 e   mt_overwrite_readmodels_workorderjobnotedetails(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_workorderjobnotedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobnotedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderjobnotedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobnotedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderjobnotedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    610056 _   mt_overwrite_readmodels_workorderjobstodo(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_workorderjobstodo(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobstodo into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderjobstodo ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobstodo into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderjobstodo(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610069 i   mt_overwrite_readmodels_workorderpickinglistdetails(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_workorderpickinglistdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderpickinglistdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderpickinglistdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderpickinglistdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderpickinglistdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            ^           1255    610082 i   mt_overwrite_readmodels_workorderrealizationdetails(jsonb, character varying, character varying, integer)    FUNCTION       CREATE FUNCTION doc.mt_overwrite_readmodels_workorderrealizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderrealizationdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_workorderrealizationdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderrealizationdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_workorderrealizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610095 Y   mt_overwrite_readmodels_zonedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_overwrite_readmodels_zonedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

  if revision = 0 then
    SELECT mt_version FROM doc.mt_doc_readmodels_zonedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    else
      revision = 1;
    end if;
  end if;

  INSERT INTO doc.mt_doc_readmodels_zonedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_zonedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_overwrite_readmodels_zonedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609617 S   mt_update_embedexternalpagemodel(jsonb, character varying, character varying, uuid)    FUNCTION       CREATE FUNCTION doc.mt_update_embedexternalpagemodel(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
  UPDATE doc.mt_doc_embedexternalpagemodel SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp() where id = docId;

  SELECT mt_version FROM doc.mt_doc_embedexternalpagemodel into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_embedexternalpagemodel(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            �           1255    609707 d   mt_update_managementdashboardpanelpositiondetails(jsonb, character varying, character varying, uuid)    FUNCTION     H  CREATE FUNCTION doc.mt_update_managementdashboardpanelpositiondetails(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
  UPDATE doc.mt_doc_managementdashboardpanelpositiondetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp() where id = docId;

  SELECT mt_version FROM doc.mt_doc_managementdashboardpanelpositiondetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_managementdashboardpanelpositiondetails(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            /           1255    609460 X   mt_update_readmodels_actiondetails(jsonb, character varying, character varying, integer)    FUNCTION     ]  CREATE FUNCTION doc.mt_update_readmodels_actiondetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_actiondetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_actiondetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_actiondetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_actiondetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_actiondetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609473 \   mt_update_readmodels_attendancehistory(jsonb, character varying, character varying, integer)    FUNCTION     q  CREATE FUNCTION doc.mt_update_readmodels_attendancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_attendancehistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_attendancehistory SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_attendancehistory.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_attendancehistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_attendancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609486 Z   mt_update_readmodels_buildingdetails(jsonb, character varying, character varying, integer)    FUNCTION     g  CREATE FUNCTION doc.mt_update_readmodels_buildingdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_buildingdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_buildingdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_buildingdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_buildingdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_buildingdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609499 \   mt_update_readmodels_currentattendance(jsonb, character varying, character varying, integer)    FUNCTION     q  CREATE FUNCTION doc.mt_update_readmodels_currentattendance(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentattendance into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_currentattendance SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentattendance.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_currentattendance into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_currentattendance(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            b           1255    609514 c   mt_update_readmodels_currentemployeeexecution(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_currentemployeeexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentemployeeexecution into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_currentemployeeexecution SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentemployeeexecution.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_currentemployeeexecution into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_currentemployeeexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609527 j   mt_update_readmodels_currentreportedquantityconsumed(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_currentreportedquantityconsumed(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentreportedquantityconsumed into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_currentreportedquantityconsumed SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentreportedquantityconsumed.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_currentreportedquantityconsumed into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_currentreportedquantityconsumed(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609540 j   mt_update_readmodels_currentreportedquantityproduced(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_currentreportedquantityproduced(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentreportedquantityproduced into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_currentreportedquantityproduced SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentreportedquantityproduced.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_currentreportedquantityproduced into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_currentreportedquantityproduced(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609553 _   mt_update_readmodels_currentresourcestate(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_currentresourcestate(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentresourcestate into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_currentresourcestate SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentresourcestate.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_currentresourcestate into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_currentresourcestate(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609566 a   mt_update_readmodels_currentshiftsettlement(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_currentshiftsettlement(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentshiftsettlement into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_currentshiftsettlement SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentshiftsettlement.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_currentshiftsettlement into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_currentshiftsettlement(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            "           1255    609579 b   mt_update_readmodels_currentworkcenterstatus(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_currentworkcenterstatus(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentworkcenterstatus into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_currentworkcenterstatus SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentworkcenterstatus.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_currentworkcenterstatus into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_currentworkcenterstatus(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609592 d   mt_update_readmodels_currentworkorderexecution(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_currentworkorderexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_currentworkorderexecution into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_currentworkorderexecution SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentworkorderexecution.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_currentworkorderexecution into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_currentworkorderexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609629 Z   mt_update_readmodels_employeedetails(jsonb, character varying, character varying, integer)    FUNCTION     g  CREATE FUNCTION doc.mt_update_readmodels_employeedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_employeedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_employeedetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_employeedetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_employeedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_employeedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609642 c   mt_update_readmodels_employeeexecutionhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_employeeexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_employeeexecutionhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_employeeexecutionhistory SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_employeeexecutionhistory.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_employeeexecutionhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_employeeexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609655 `   mt_update_readmodels_executionstatedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_executionstatedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_executionstatedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_executionstatedetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_executionstatedetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_executionstatedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_executionstatedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609668 [   mt_update_readmodels_executionsummary(jsonb, character varying, character varying, integer)    FUNCTION     l  CREATE FUNCTION doc.mt_update_readmodels_executionsummary(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_executionsummary into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_executionsummary SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_executionsummary.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_executionsummary into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_executionsummary(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609681 Y   mt_update_readmodels_factorydetails(jsonb, character varying, character varying, integer)    FUNCTION     b  CREATE FUNCTION doc.mt_update_readmodels_factorydetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_factorydetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_factorydetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_factorydetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_factorydetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_factorydetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609694 W   mt_update_readmodels_floordetails(jsonb, character varying, character varying, integer)    FUNCTION     X  CREATE FUNCTION doc.mt_update_readmodels_floordetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_floordetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_floordetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_floordetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_floordetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_floordetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609719 ^   mt_update_readmodels_organizationdetails(jsonb, character varying, character varying, integer)    FUNCTION     {  CREATE FUNCTION doc.mt_update_readmodels_organizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_organizationdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_organizationdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_organizationdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_organizationdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_organizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609732 j   mt_update_readmodels_reportedquantityconsumedhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_reportedquantityconsumedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_reportedquantityconsumedhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_reportedquantityconsumedhistory SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_reportedquantityconsumedhistory.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_reportedquantityconsumedhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_reportedquantityconsumedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609745 j   mt_update_readmodels_reportedquantityproducedhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_reportedquantityproducedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_reportedquantityproducedhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_reportedquantityproducedhistory SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_reportedquantityproducedhistory.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_reportedquantityproducedhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_reportedquantityproducedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            T           1255    609758 Z   mt_update_readmodels_resourcedetails(jsonb, character varying, character varying, integer)    FUNCTION     g  CREATE FUNCTION doc.mt_update_readmodels_resourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_resourcedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_resourcedetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_resourcedetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_resourcedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_resourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            ,           1255    609771 _   mt_update_readmodels_resourcestatehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_resourcestatehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_resourcestatehistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_resourcestatehistory SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_resourcestatehistory.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_resourcestatehistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_resourcestatehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            %           1255    609784 k   mt_update_readmodels_shiftsettlementacceptancehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_shiftsettlementacceptancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_shiftsettlementacceptancehistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_shiftsettlementacceptancehistory SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_shiftsettlementacceptancehistory.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_shiftsettlementacceptancehistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_shiftsettlementacceptancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609797 a   mt_update_readmodels_shiftsettlementhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_shiftsettlementhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_shiftsettlementhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_shiftsettlementhistory SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_shiftsettlementhistory.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_shiftsettlementhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_shiftsettlementhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            Q           1255    609810 V   mt_update_readmodels_shiftsystem(jsonb, character varying, character varying, integer)    FUNCTION     S  CREATE FUNCTION doc.mt_update_readmodels_shiftsystem(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_shiftsystem into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_shiftsystem SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_shiftsystem.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_shiftsystem into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_shiftsystem(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            W           1255    609823 Z   mt_update_readmodels_terminaldetails(jsonb, character varying, character varying, integer)    FUNCTION     g  CREATE FUNCTION doc.mt_update_readmodels_terminaldetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_terminaldetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_terminaldetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_terminaldetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_terminaldetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_terminaldetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609836 e   mt_update_readmodels_typeoffinishedgoodsdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_typeoffinishedgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_typeoffinishedgoodsdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_typeoffinishedgoodsdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_typeoffinishedgoodsdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_typeoffinishedgoodsdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_typeoffinishedgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609849 Y   mt_update_readmodels_userconfiguration(jsonb, character varying, character varying, uuid)    FUNCTION     '  CREATE FUNCTION doc.mt_update_readmodels_userconfiguration(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
  UPDATE doc.mt_doc_readmodels_userconfiguration SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp() where id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_userconfiguration into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_userconfiguration(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            [           1255    609861 V   mt_update_readmodels_userdetails(jsonb, character varying, character varying, integer)    FUNCTION     S  CREATE FUNCTION doc.mt_update_readmodels_userdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_userdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_userdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_userdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_userdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_userdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609874 ^   mt_update_readmodels_userlocalizationfilter(jsonb, character varying, character varying, uuid)    FUNCTION     6  CREATE FUNCTION doc.mt_update_readmodels_userlocalizationfilter(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
  UPDATE doc.mt_doc_readmodels_userlocalizationfilter SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp() where id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_userlocalizationfilter into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_userlocalizationfilter(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            �           1255    609886 [   mt_update_readmodels_usertokendetails(jsonb, character varying, character varying, integer)    FUNCTION     l  CREATE FUNCTION doc.mt_update_readmodels_usertokendetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_usertokendetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_usertokendetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_usertokendetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_usertokendetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_usertokendetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609899 \   mt_update_readmodels_workcenterdetails(jsonb, character varying, character varying, integer)    FUNCTION     q  CREATE FUNCTION doc.mt_update_readmodels_workcenterdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcenterdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workcenterdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcenterdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workcenterdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workcenterdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609912 d   mt_update_readmodels_workcenterresourcedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_workcenterresourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcenterresourcedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workcenterresourcedetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcenterresourcedetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workcenterresourcedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workcenterresourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609925 Z   mt_update_readmodels_workcenterstate(jsonb, character varying, character varying, integer)    FUNCTION     g  CREATE FUNCTION doc.mt_update_readmodels_workcenterstate(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcenterstate into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workcenterstate SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcenterstate.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workcenterstate into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workcenterstate(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609938 b   mt_update_readmodels_workcenterstatushistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_workcenterstatushistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcenterstatushistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workcenterstatushistory SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcenterstatushistory.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workcenterstatushistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workcenterstatushistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609951 c   mt_update_readmodels_workcentertoresourcebond(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_workcentertoresourcebond(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workcentertoresourcebond into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workcentertoresourcebond SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcentertoresourcebond.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workcentertoresourcebond into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workcentertoresourcebond(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            g           1255    609964 ^   mt_update_readmodels_workorderbomdetails(jsonb, character varying, character varying, integer)    FUNCTION     {  CREATE FUNCTION doc.mt_update_readmodels_workorderbomdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderbomdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderbomdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderbomdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderbomdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderbomdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            z           1255    609977 [   mt_update_readmodels_workorderdetails(jsonb, character varying, character varying, integer)    FUNCTION     l  CREATE FUNCTION doc.mt_update_readmodels_workorderdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609990 d   mt_update_readmodels_workorderexecutionhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_workorderexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderexecutionhistory into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderexecutionhistory SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderexecutionhistory.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderexecutionhistory into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            k           1255    610003 i   mt_update_readmodels_workorderexecutionresourcelink(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_workorderexecutionresourcelink(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderexecutionresourcelink into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderexecutionresourcelink SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderexecutionresourcelink.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderexecutionresourcelink into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderexecutionresourcelink(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            *           1255    610016 f   mt_update_readmodels_workorderfinishgoodsdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_workorderfinishgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderfinishgoodsdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderfinishgoodsdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderfinishgoodsdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderfinishgoodsdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderfinishgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    610029 ^   mt_update_readmodels_workorderjobdetails(jsonb, character varying, character varying, integer)    FUNCTION     {  CREATE FUNCTION doc.mt_update_readmodels_workorderjobdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderjobdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderjobdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderjobdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610042 b   mt_update_readmodels_workorderjobnotedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_workorderjobnotedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobnotedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderjobnotedetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderjobnotedetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobnotedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderjobnotedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610055 \   mt_update_readmodels_workorderjobstodo(jsonb, character varying, character varying, integer)    FUNCTION     q  CREATE FUNCTION doc.mt_update_readmodels_workorderjobstodo(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobstodo into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderjobstodo SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderjobstodo.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderjobstodo into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderjobstodo(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            :           1255    610068 f   mt_update_readmodels_workorderpickinglistdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_workorderpickinglistdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderpickinglistdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderpickinglistdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderpickinglistdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderpickinglistdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderpickinglistdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            #           1255    610081 f   mt_update_readmodels_workorderrealizationdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_update_readmodels_workorderrealizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_workorderrealizationdetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_workorderrealizationdetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderrealizationdetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_workorderrealizationdetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_workorderrealizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            y           1255    610094 V   mt_update_readmodels_zonedetails(jsonb, character varying, character varying, integer)    FUNCTION     S  CREATE FUNCTION doc.mt_update_readmodels_zonedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN
  if revision <= 1 then
    SELECT mt_version FROM doc.mt_doc_readmodels_zonedetails into current_version WHERE id = docId ;
    if current_version is not null then
      revision = current_version + 1;
    end if;
  end if;

  UPDATE doc.mt_doc_readmodels_zonedetails SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_zonedetails.mt_version and id = docId;

  SELECT mt_version FROM doc.mt_doc_readmodels_zonedetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_update_readmodels_zonedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            A           1255    609615 S   mt_upsert_embedexternalpagemodel(jsonb, character varying, character varying, uuid)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_embedexternalpagemodel(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
INSERT INTO doc.mt_doc_embedexternalpagemodel ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_embedexternalpagemodel into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_embedexternalpagemodel(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            �           1255    609705 d   mt_upsert_managementdashboardpanelpositiondetails(jsonb, character varying, character varying, uuid)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_managementdashboardpanelpositiondetails(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
INSERT INTO doc.mt_doc_managementdashboardpanelpositiondetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_managementdashboardpanelpositiondetails into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_managementdashboardpanelpositiondetails(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            F           1255    609458 X   mt_upsert_readmodels_actiondetails(jsonb, character varying, character varying, integer)    FUNCTION     {  CREATE FUNCTION doc.mt_upsert_readmodels_actiondetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_actiondetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_actiondetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_actiondetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_actiondetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_actiondetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            {           1255    609471 \   mt_upsert_readmodels_attendancehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_attendancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_attendancehistory WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_attendancehistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_attendancehistory.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_attendancehistory WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_attendancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            f           1255    609484 Z   mt_upsert_readmodels_buildingdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_buildingdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_buildingdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_buildingdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_buildingdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_buildingdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_buildingdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            j           1255    609497 \   mt_upsert_readmodels_currentattendance(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_currentattendance(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_currentattendance WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_currentattendance ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentattendance.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_currentattendance WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_currentattendance(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609512 c   mt_upsert_readmodels_currentemployeeexecution(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_currentemployeeexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_currentemployeeexecution WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_currentemployeeexecution ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentemployeeexecution.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_currentemployeeexecution WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_currentemployeeexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609525 j   mt_upsert_readmodels_currentreportedquantityconsumed(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_currentreportedquantityconsumed(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_currentreportedquantityconsumed WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_currentreportedquantityconsumed ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentreportedquantityconsumed.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_currentreportedquantityconsumed WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_currentreportedquantityconsumed(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609538 j   mt_upsert_readmodels_currentreportedquantityproduced(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_currentreportedquantityproduced(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_currentreportedquantityproduced WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_currentreportedquantityproduced ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentreportedquantityproduced.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_currentreportedquantityproduced WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_currentreportedquantityproduced(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609551 _   mt_upsert_readmodels_currentresourcestate(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_currentresourcestate(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_currentresourcestate WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_currentresourcestate ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentresourcestate.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_currentresourcestate WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_currentresourcestate(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609564 a   mt_upsert_readmodels_currentshiftsettlement(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_currentshiftsettlement(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_currentshiftsettlement WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_currentshiftsettlement ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentshiftsettlement.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_currentshiftsettlement WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_currentshiftsettlement(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609577 b   mt_upsert_readmodels_currentworkcenterstatus(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_currentworkcenterstatus(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_currentworkcenterstatus WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_currentworkcenterstatus ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentworkcenterstatus.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_currentworkcenterstatus WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_currentworkcenterstatus(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609590 d   mt_upsert_readmodels_currentworkorderexecution(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_currentworkorderexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_currentworkorderexecution WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_currentworkorderexecution ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_currentworkorderexecution.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_currentworkorderexecution WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_currentworkorderexecution(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609627 Z   mt_upsert_readmodels_employeedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_employeedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_employeedetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_employeedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_employeedetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_employeedetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_employeedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            |           1255    609640 c   mt_upsert_readmodels_employeeexecutionhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_employeeexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_employeeexecutionhistory WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_employeeexecutionhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_employeeexecutionhistory.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_employeeexecutionhistory WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_employeeexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609653 `   mt_upsert_readmodels_executionstatedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_executionstatedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_executionstatedetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_executionstatedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_executionstatedetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_executionstatedetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_executionstatedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609666 [   mt_upsert_readmodels_executionsummary(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_executionsummary(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_executionsummary WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_executionsummary ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_executionsummary.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_executionsummary WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_executionsummary(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            H           1255    609679 Y   mt_upsert_readmodels_factorydetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_factorydetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_factorydetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_factorydetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_factorydetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_factorydetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_factorydetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            '           1255    609692 W   mt_upsert_readmodels_floordetails(jsonb, character varying, character varying, integer)    FUNCTION     v  CREATE FUNCTION doc.mt_upsert_readmodels_floordetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_floordetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_floordetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_floordetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_floordetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_floordetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            _           1255    609717 ^   mt_upsert_readmodels_organizationdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_organizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_organizationdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_organizationdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_organizationdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_organizationdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_organizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            6           1255    609730 j   mt_upsert_readmodels_reportedquantityconsumedhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_reportedquantityconsumedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_reportedquantityconsumedhistory WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_reportedquantityconsumedhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_reportedquantityconsumedhistory.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_reportedquantityconsumedhistory WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_reportedquantityconsumedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609743 j   mt_upsert_readmodels_reportedquantityproducedhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_reportedquantityproducedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_reportedquantityproducedhistory WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_reportedquantityproducedhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_reportedquantityproducedhistory.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_reportedquantityproducedhistory WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_reportedquantityproducedhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609756 Z   mt_upsert_readmodels_resourcedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_resourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_resourcedetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_resourcedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_resourcedetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_resourcedetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_resourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609769 _   mt_upsert_readmodels_resourcestatehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_resourcestatehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_resourcestatehistory WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_resourcestatehistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_resourcestatehistory.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_resourcestatehistory WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_resourcestatehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            I           1255    609782 k   mt_upsert_readmodels_shiftsettlementacceptancehistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_shiftsettlementacceptancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_shiftsettlementacceptancehistory WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_shiftsettlementacceptancehistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_shiftsettlementacceptancehistory.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_shiftsettlementacceptancehistory WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_shiftsettlementacceptancehistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            S           1255    609795 a   mt_upsert_readmodels_shiftsettlementhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_shiftsettlementhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_shiftsettlementhistory WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_shiftsettlementhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_shiftsettlementhistory.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_shiftsettlementhistory WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_shiftsettlementhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            c           1255    609808 V   mt_upsert_readmodels_shiftsystem(jsonb, character varying, character varying, integer)    FUNCTION     q  CREATE FUNCTION doc.mt_upsert_readmodels_shiftsystem(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_shiftsystem WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_shiftsystem ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_shiftsystem.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_shiftsystem WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_shiftsystem(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            >           1255    609821 Z   mt_upsert_readmodels_terminaldetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_terminaldetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_terminaldetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_terminaldetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_terminaldetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_terminaldetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_terminaldetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609834 e   mt_upsert_readmodels_typeoffinishedgoodsdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_typeoffinishedgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_typeoffinishedgoodsdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_typeoffinishedgoodsdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_typeoffinishedgoodsdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_typeoffinishedgoodsdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_typeoffinishedgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            D           1255    609847 Y   mt_upsert_readmodels_userconfiguration(jsonb, character varying, character varying, uuid)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_userconfiguration(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
INSERT INTO doc.mt_doc_readmodels_userconfiguration ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_userconfiguration into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_userconfiguration(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            ?           1255    609859 V   mt_upsert_readmodels_userdetails(jsonb, character varying, character varying, integer)    FUNCTION     q  CREATE FUNCTION doc.mt_upsert_readmodels_userdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_userdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_userdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_userdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_userdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_userdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609872 ^   mt_upsert_readmodels_userlocalizationfilter(jsonb, character varying, character varying, uuid)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_userlocalizationfilter(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
INSERT INTO doc.mt_doc_readmodels_userlocalizationfilter ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM doc.mt_doc_readmodels_userlocalizationfilter into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_userlocalizationfilter(doc jsonb, docdotnettype character varying, docid character varying, docversion uuid);
       doc          postgres    false    6            )           1255    609884 [   mt_upsert_readmodels_usertokendetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_usertokendetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_usertokendetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_usertokendetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_usertokendetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_usertokendetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_usertokendetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            @           1255    609897 \   mt_upsert_readmodels_workcenterdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workcenterdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workcenterdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workcenterdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcenterdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workcenterdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workcenterdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609910 d   mt_upsert_readmodels_workcenterresourcedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workcenterresourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workcenterresourcedetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workcenterresourcedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcenterresourcedetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workcenterresourcedetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workcenterresourcedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            d           1255    609923 Z   mt_upsert_readmodels_workcenterstate(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workcenterstate(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workcenterstate WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workcenterstate ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcenterstate.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workcenterstate WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workcenterstate(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            +           1255    609936 b   mt_upsert_readmodels_workcenterstatushistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workcenterstatushistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workcenterstatushistory WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workcenterstatushistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcenterstatushistory.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workcenterstatushistory WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workcenterstatushistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6                       1255    609949 c   mt_upsert_readmodels_workcentertoresourcebond(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workcentertoresourcebond(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workcentertoresourcebond WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workcentertoresourcebond ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workcentertoresourcebond.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workcentertoresourcebond WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workcentertoresourcebond(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            V           1255    609962 ^   mt_upsert_readmodels_workorderbomdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderbomdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderbomdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderbomdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderbomdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderbomdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderbomdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    609975 [   mt_upsert_readmodels_workorderdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            i           1255    609988 d   mt_upsert_readmodels_workorderexecutionhistory(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderexecutionhistory WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderexecutionhistory ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderexecutionhistory.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderexecutionhistory WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderexecutionhistory(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            \           1255    610001 i   mt_upsert_readmodels_workorderexecutionresourcelink(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderexecutionresourcelink(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderexecutionresourcelink WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderexecutionresourcelink ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderexecutionresourcelink.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderexecutionresourcelink WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderexecutionresourcelink(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610014 f   mt_upsert_readmodels_workorderfinishgoodsdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderfinishgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderfinishgoodsdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderfinishgoodsdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderfinishgoodsdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderfinishgoodsdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderfinishgoodsdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610027 ^   mt_upsert_readmodels_workorderjobdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderjobdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderjobdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderjobdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderjobdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderjobdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderjobdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            u           1255    610040 b   mt_upsert_readmodels_workorderjobnotedetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderjobnotedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderjobnotedetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderjobnotedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderjobnotedetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderjobnotedetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderjobnotedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610053 \   mt_upsert_readmodels_workorderjobstodo(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderjobstodo(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderjobstodo WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderjobstodo ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderjobstodo.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderjobstodo WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderjobstodo(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            E           1255    610066 f   mt_upsert_readmodels_workorderpickinglistdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderpickinglistdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderpickinglistdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderpickinglistdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderpickinglistdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderpickinglistdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderpickinglistdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610079 f   mt_upsert_readmodels_workorderrealizationdetails(jsonb, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION doc.mt_upsert_readmodels_workorderrealizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_workorderrealizationdetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_workorderrealizationdetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_workorderrealizationdetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_workorderrealizationdetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_workorderrealizationdetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            �           1255    610092 V   mt_upsert_readmodels_zonedetails(jsonb, character varying, character varying, integer)    FUNCTION     q  CREATE FUNCTION doc.mt_upsert_readmodels_zonedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version INTEGER;
  current_version INTEGER;
BEGIN

SELECT mt_version into current_version FROM doc.mt_doc_readmodels_zonedetails WHERE id = docId ;
if revision = 0 then
  if current_version is not null then
    revision = current_version + 1;
  else
    revision = 1;
  end if;
else
  if current_version is not null then
    if current_version >= revision then
      return 0;
    end if;
  end if;
end if;

INSERT INTO doc.mt_doc_readmodels_zonedetails ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, revision, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = revision, mt_last_modified = transaction_timestamp() where revision > doc.mt_doc_readmodels_zonedetails.mt_version;

  SELECT mt_version into final_version FROM doc.mt_doc_readmodels_zonedetails WHERE id = docId ;
  RETURN final_version;
END;
$$;
 �   DROP FUNCTION doc.mt_upsert_readmodels_zonedetails(doc jsonb, docdotnettype character varying, docid character varying, revision integer);
       doc          postgres    false    6            P           1255    610133 $   mt_archive_stream(character varying)    FUNCTION     
  CREATE FUNCTION es.mt_archive_stream(streamid character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  update es.mt_streams set is_archived = TRUE where id = streamid ;
  update es.mt_events set is_archived = TRUE where stream_id = streamid ;
END;
$$;
 @   DROP FUNCTION es.mt_archive_stream(streamid character varying);
       es          postgres    false    7            �           1255    609604 ?   mt_insert_deadletterevent(jsonb, character varying, uuid, uuid)    FUNCTION     w  CREATE FUNCTION es.mt_insert_deadletterevent(doc jsonb, docdotnettype character varying, docid uuid, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO es.mt_doc_deadletterevent ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp());

  RETURN docVersion;
END;
$$;
 u   DROP FUNCTION es.mt_insert_deadletterevent(doc jsonb, docdotnettype character varying, docid uuid, docversion uuid);
       es          postgres    false    7            e           1255    610132 4   mt_mark_event_progression(character varying, bigint)    FUNCTION     �  CREATE FUNCTION es.mt_mark_event_progression(name character varying, last_encountered bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO es.mt_event_progression (name, last_seq_id, last_updated)
VALUES (name, last_encountered, transaction_timestamp())
ON CONFLICT ON CONSTRAINT pk_mt_event_progression
    DO
UPDATE SET last_seq_id = last_encountered, last_updated = transaction_timestamp();

END;

$$;
 ]   DROP FUNCTION es.mt_mark_event_progression(name character varying, last_encountered bigint);
       es          postgres    false    7            R           1255    610134 �   mt_quick_append_events(character varying, character varying, character varying, uuid[], character varying[], character varying[], jsonb[])    FUNCTION     �  CREATE FUNCTION es.mt_quick_append_events(stream character varying, stream_type character varying, tenantid character varying, event_ids uuid[], event_types character varying[], dotnet_types character varying[], bodies jsonb[]) RETURNS integer[]
    LANGUAGE plpgsql
    AS $$
DECLARE
	event_version int;
	event_type varchar;
	event_id uuid;
	body jsonb;
	index int;
	seq int;
    actual_tenant varchar;
	return_value int[];
BEGIN
	select version into event_version from es.mt_streams where id = stream;
	if event_version IS NULL then
		event_version = 0;
		insert into es.mt_streams (id, type, version, timestamp, tenant_id) values (stream, stream_type, 0, now(), tenantid);
    else
        if tenantid IS NOT NULL then
            select tenant_id into actual_tenant from es.mt_streams where id = stream;
            if actual_tenant != tenantid then
                RAISE EXCEPTION 'The tenantid does not match the existing stream';
            end if;
        end if;
	end if;

	index := 1;
	return_value := ARRAY[event_version + array_length(event_ids, 1)];

	foreach event_id in ARRAY event_ids
	loop
	    seq := nextval('es.mt_events_sequence');
		return_value := array_append(return_value, seq);

	    event_version := event_version + 1;
		event_type = event_types[index];
		body = bodies[index];

		insert into es.mt_events
			(seq_id, id, stream_id, version, data, type, tenant_id, timestamp, mt_dotnet_type, is_archived)
		values
			(seq, event_id, stream, event_version, body, event_type, tenantid, (now() at time zone 'utc'), dotnet_types[index], FALSE);

		index := index + 1;
	end loop;

	update es.mt_streams set version = event_version, timestamp = now() where id = stream;

	return return_value;
END
$$;
 �   DROP FUNCTION es.mt_quick_append_events(stream character varying, stream_type character varying, tenantid character varying, event_ids uuid[], event_types character varying[], dotnet_types character varying[], bodies jsonb[]);
       es          postgres    false    7            �           1255    609605 ?   mt_update_deadletterevent(jsonb, character varying, uuid, uuid)    FUNCTION     �  CREATE FUNCTION es.mt_update_deadletterevent(doc jsonb, docdotnettype character varying, docid uuid, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
  UPDATE es.mt_doc_deadletterevent SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp() where id = docId;

  SELECT mt_version FROM es.mt_doc_deadletterevent into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 u   DROP FUNCTION es.mt_update_deadletterevent(doc jsonb, docdotnettype character varying, docid uuid, docversion uuid);
       es          postgres    false    7            �           1255    609603 ?   mt_upsert_deadletterevent(jsonb, character varying, uuid, uuid)    FUNCTION     �  CREATE FUNCTION es.mt_upsert_deadletterevent(doc jsonb, docdotnettype character varying, docid uuid, docversion uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  final_version uuid;
BEGIN
INSERT INTO es.mt_doc_deadletterevent ("data", "mt_dotnet_type", "id", "mt_version", mt_last_modified) VALUES (doc, docDotNetType, docId, docVersion, transaction_timestamp())
  ON CONFLICT (id)
  DO UPDATE SET "data" = doc, "mt_dotnet_type" = docDotNetType, "mt_version" = docVersion, mt_last_modified = transaction_timestamp();

  SELECT mt_version FROM es.mt_doc_deadletterevent into final_version WHERE id = docId ;
  RETURN final_version;
END;
$$;
 u   DROP FUNCTION es.mt_upsert_deadletterevent(doc jsonb, docdotnettype character varying, docid uuid, docversion uuid);
       es          postgres    false    7            �            1259    609568 )   mt_doc_readmodels_currentworkcenterstatus    TABLE       CREATE TABLE doc.mt_doc_readmodels_currentworkcenterstatus (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 :   DROP TABLE doc.mt_doc_readmodels_currentworkcenterstatus;
       doc         heap    postgres    false    6                       1259    610005 -   mt_doc_readmodels_workorderfinishgoodsdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_workorderfinishgoodsdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 >   DROP TABLE doc.mt_doc_readmodels_workorderfinishgoodsdetails;
       doc         heap    postgres    false    6                       1259    610139    currentworkcenterstatus_view    VIEW     �  CREATE VIEW doc.currentworkcenterstatus_view AS
 SELECT ((cws.data -> 'WorkCenter'::text) ->> 'Symbol'::text) AS workcentersymbol,
    ((cws.data -> 'WorkCenter'::text) ->> 'Name'::text) AS workcentername,
    ((cws.data -> 'State'::text) ->> 'Type'::text) AS workcenterstatetype,
    ((cws.data -> 'State'::text) ->> 'Name'::text) AS workcenterstatename,
    (cws.data -> 'CurrentNumberOfEmployees'::text) AS currentnumberofemployees,
    ((cws.data -> 'WorkOrder'::text) ->> 'Id'::text) AS workorderid,
    ((cws.data -> 'WorkOrder'::text) ->> 'ProductionNumber'::text) AS workorderproductionnumber,
    ((cws.data -> 'WorkOrder'::text) ->> 'Name'::text) AS workordername,
    ((cws.data -> 'WorkOrder'::text) ->> 'BatchNumber'::text) AS workorderbatchnumber,
    ((cws.data -> 'WorkOrder'::text) ->> 'Description'::text) AS workorderdescription,
    (((cws.data -> 'WorkOrderJobs'::text) -> 0) ->> 'ScheduledBegin'::text) AS workorderjobscheduledbegin,
    (((cws.data -> 'WorkOrderJobs'::text) -> 0) ->> 'ScheduledEnd'::text) AS workorderjobscheduledend,
    (((cws.data -> 'WorkOrderJobs'::text) -> 0) ->> 'NumberOfPeople'::text) AS workorderjobnumberofpeople,
    (wofgd.data ->> 'ItemId'::text) AS itemid,
    (wofgd.data ->> 'ItemDescription'::text) AS itemdescription,
    (wofgd.data ->> 'UnitOfMeasure'::text) AS unitofmeasure,
    (wofgd.data ->> 'QuantityCommissioned'::text) AS quantitycommissioned,
    (wofgd.data ->> 'QuantityOrdered'::text) AS quantityordered
   FROM (doc.mt_doc_readmodels_currentworkcenterstatus cws
     LEFT JOIN doc.mt_doc_readmodels_workorderfinishgoodsdetails wofgd ON ((((cws.data -> 'WorkOrder'::text) ->> 'Id'::text) = (wofgd.data ->> 'WorkOrderId'::text))));
 ,   DROP VIEW doc.currentworkcenterstatus_view;
       doc          postgres    false    226    260    6            �            1259    609606    mt_doc_embedexternalpagemodel    TABLE     G  CREATE TABLE doc.mt_doc_embedexternalpagemodel (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_version uuid DEFAULT (md5(((random())::text || (clock_timestamp())::text)))::uuid NOT NULL,
    mt_dotnet_type character varying
);
 .   DROP TABLE doc.mt_doc_embedexternalpagemodel;
       doc         heap    postgres    false    6            �            1259    609696 .   mt_doc_managementdashboardpanelpositiondetails    TABLE     X  CREATE TABLE doc.mt_doc_managementdashboardpanelpositiondetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_version uuid DEFAULT (md5(((random())::text || (clock_timestamp())::text)))::uuid NOT NULL,
    mt_dotnet_type character varying
);
 ?   DROP TABLE doc.mt_doc_managementdashboardpanelpositiondetails;
       doc         heap    postgres    false    6            �            1259    609449    mt_doc_readmodels_actiondetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_actiondetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 0   DROP TABLE doc.mt_doc_readmodels_actiondetails;
       doc         heap    postgres    false    6            �            1259    609462 #   mt_doc_readmodels_attendancehistory    TABLE       CREATE TABLE doc.mt_doc_readmodels_attendancehistory (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 4   DROP TABLE doc.mt_doc_readmodels_attendancehistory;
       doc         heap    postgres    false    6            �            1259    609475 !   mt_doc_readmodels_buildingdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_buildingdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 2   DROP TABLE doc.mt_doc_readmodels_buildingdetails;
       doc         heap    postgres    false    6            �            1259    609488 #   mt_doc_readmodels_currentattendance    TABLE       CREATE TABLE doc.mt_doc_readmodels_currentattendance (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 4   DROP TABLE doc.mt_doc_readmodels_currentattendance;
       doc         heap    postgres    false    6            �            1259    609501 *   mt_doc_readmodels_currentemployeeexecution    TABLE     n  CREATE TABLE doc.mt_doc_readmodels_currentemployeeexecution (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL,
    mt_deleted boolean DEFAULT false,
    mt_deleted_at timestamp with time zone
);
 ;   DROP TABLE doc.mt_doc_readmodels_currentemployeeexecution;
       doc         heap    postgres    false    6            �            1259    609516 1   mt_doc_readmodels_currentreportedquantityconsumed    TABLE     #  CREATE TABLE doc.mt_doc_readmodels_currentreportedquantityconsumed (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 B   DROP TABLE doc.mt_doc_readmodels_currentreportedquantityconsumed;
       doc         heap    postgres    false    6            �            1259    609529 1   mt_doc_readmodels_currentreportedquantityproduced    TABLE     #  CREATE TABLE doc.mt_doc_readmodels_currentreportedquantityproduced (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 B   DROP TABLE doc.mt_doc_readmodels_currentreportedquantityproduced;
       doc         heap    postgres    false    6            �            1259    609542 &   mt_doc_readmodels_currentresourcestate    TABLE       CREATE TABLE doc.mt_doc_readmodels_currentresourcestate (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 7   DROP TABLE doc.mt_doc_readmodels_currentresourcestate;
       doc         heap    postgres    false    6            �            1259    609555 (   mt_doc_readmodels_currentshiftsettlement    TABLE       CREATE TABLE doc.mt_doc_readmodels_currentshiftsettlement (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 9   DROP TABLE doc.mt_doc_readmodels_currentshiftsettlement;
       doc         heap    postgres    false    6            �            1259    609581 +   mt_doc_readmodels_currentworkorderexecution    TABLE       CREATE TABLE doc.mt_doc_readmodels_currentworkorderexecution (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 <   DROP TABLE doc.mt_doc_readmodels_currentworkorderexecution;
       doc         heap    postgres    false    6            �            1259    609618 !   mt_doc_readmodels_employeedetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_employeedetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 2   DROP TABLE doc.mt_doc_readmodels_employeedetails;
       doc         heap    postgres    false    6            �            1259    609631 *   mt_doc_readmodels_employeeexecutionhistory    TABLE       CREATE TABLE doc.mt_doc_readmodels_employeeexecutionhistory (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 ;   DROP TABLE doc.mt_doc_readmodels_employeeexecutionhistory;
       doc         heap    postgres    false    6            �            1259    609644 '   mt_doc_readmodels_executionstatedetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_executionstatedetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 8   DROP TABLE doc.mt_doc_readmodels_executionstatedetails;
       doc         heap    postgres    false    6            �            1259    609657 "   mt_doc_readmodels_executionsummary    TABLE       CREATE TABLE doc.mt_doc_readmodels_executionsummary (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 3   DROP TABLE doc.mt_doc_readmodels_executionsummary;
       doc         heap    postgres    false    6            �            1259    609670     mt_doc_readmodels_factorydetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_factorydetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 1   DROP TABLE doc.mt_doc_readmodels_factorydetails;
       doc         heap    postgres    false    6            �            1259    609683    mt_doc_readmodels_floordetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_floordetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 /   DROP TABLE doc.mt_doc_readmodels_floordetails;
       doc         heap    postgres    false    6            �            1259    609708 %   mt_doc_readmodels_organizationdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_organizationdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 6   DROP TABLE doc.mt_doc_readmodels_organizationdetails;
       doc         heap    postgres    false    6            �            1259    609721 1   mt_doc_readmodels_reportedquantityconsumedhistory    TABLE     #  CREATE TABLE doc.mt_doc_readmodels_reportedquantityconsumedhistory (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 B   DROP TABLE doc.mt_doc_readmodels_reportedquantityconsumedhistory;
       doc         heap    postgres    false    6            �            1259    609734 1   mt_doc_readmodels_reportedquantityproducedhistory    TABLE     #  CREATE TABLE doc.mt_doc_readmodels_reportedquantityproducedhistory (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 B   DROP TABLE doc.mt_doc_readmodels_reportedquantityproducedhistory;
       doc         heap    postgres    false    6            �            1259    609747 !   mt_doc_readmodels_resourcedetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_resourcedetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 2   DROP TABLE doc.mt_doc_readmodels_resourcedetails;
       doc         heap    postgres    false    6            �            1259    609760 &   mt_doc_readmodels_resourcestatehistory    TABLE       CREATE TABLE doc.mt_doc_readmodels_resourcestatehistory (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 7   DROP TABLE doc.mt_doc_readmodels_resourcestatehistory;
       doc         heap    postgres    false    6            �            1259    609773 2   mt_doc_readmodels_shiftsettlementacceptancehistory    TABLE     $  CREATE TABLE doc.mt_doc_readmodels_shiftsettlementacceptancehistory (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 C   DROP TABLE doc.mt_doc_readmodels_shiftsettlementacceptancehistory;
       doc         heap    postgres    false    6            �            1259    609786 (   mt_doc_readmodels_shiftsettlementhistory    TABLE       CREATE TABLE doc.mt_doc_readmodels_shiftsettlementhistory (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 9   DROP TABLE doc.mt_doc_readmodels_shiftsettlementhistory;
       doc         heap    postgres    false    6            �            1259    609799    mt_doc_readmodels_shiftsystem    TABLE       CREATE TABLE doc.mt_doc_readmodels_shiftsystem (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 .   DROP TABLE doc.mt_doc_readmodels_shiftsystem;
       doc         heap    postgres    false    6            �            1259    609812 !   mt_doc_readmodels_terminaldetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_terminaldetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 2   DROP TABLE doc.mt_doc_readmodels_terminaldetails;
       doc         heap    postgres    false    6            �            1259    609825 ,   mt_doc_readmodels_typeoffinishedgoodsdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_typeoffinishedgoodsdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 =   DROP TABLE doc.mt_doc_readmodels_typeoffinishedgoodsdetails;
       doc         heap    postgres    false    6            �            1259    609838 #   mt_doc_readmodels_userconfiguration    TABLE     M  CREATE TABLE doc.mt_doc_readmodels_userconfiguration (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_version uuid DEFAULT (md5(((random())::text || (clock_timestamp())::text)))::uuid NOT NULL,
    mt_dotnet_type character varying
);
 4   DROP TABLE doc.mt_doc_readmodels_userconfiguration;
       doc         heap    postgres    false    6            �            1259    609850    mt_doc_readmodels_userdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_userdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 .   DROP TABLE doc.mt_doc_readmodels_userdetails;
       doc         heap    postgres    false    6            �            1259    609863 (   mt_doc_readmodels_userlocalizationfilter    TABLE     R  CREATE TABLE doc.mt_doc_readmodels_userlocalizationfilter (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_version uuid DEFAULT (md5(((random())::text || (clock_timestamp())::text)))::uuid NOT NULL,
    mt_dotnet_type character varying
);
 9   DROP TABLE doc.mt_doc_readmodels_userlocalizationfilter;
       doc         heap    postgres    false    6            �            1259    609875 "   mt_doc_readmodels_usertokendetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_usertokendetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 3   DROP TABLE doc.mt_doc_readmodels_usertokendetails;
       doc         heap    postgres    false    6            �            1259    609888 #   mt_doc_readmodels_workcenterdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_workcenterdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 4   DROP TABLE doc.mt_doc_readmodels_workcenterdetails;
       doc         heap    postgres    false    6            �            1259    609901 +   mt_doc_readmodels_workcenterresourcedetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_workcenterresourcedetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 <   DROP TABLE doc.mt_doc_readmodels_workcenterresourcedetails;
       doc         heap    postgres    false    6            �            1259    609914 !   mt_doc_readmodels_workcenterstate    TABLE       CREATE TABLE doc.mt_doc_readmodels_workcenterstate (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 2   DROP TABLE doc.mt_doc_readmodels_workcenterstate;
       doc         heap    postgres    false    6            �            1259    609927 )   mt_doc_readmodels_workcenterstatushistory    TABLE       CREATE TABLE doc.mt_doc_readmodels_workcenterstatushistory (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 :   DROP TABLE doc.mt_doc_readmodels_workcenterstatushistory;
       doc         heap    postgres    false    6            �            1259    609940 *   mt_doc_readmodels_workcentertoresourcebond    TABLE       CREATE TABLE doc.mt_doc_readmodels_workcentertoresourcebond (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 ;   DROP TABLE doc.mt_doc_readmodels_workcentertoresourcebond;
       doc         heap    postgres    false    6                        1259    609953 %   mt_doc_readmodels_workorderbomdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_workorderbomdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 6   DROP TABLE doc.mt_doc_readmodels_workorderbomdetails;
       doc         heap    postgres    false    6                       1259    609966 "   mt_doc_readmodels_workorderdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_workorderdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 3   DROP TABLE doc.mt_doc_readmodels_workorderdetails;
       doc         heap    postgres    false    6                       1259    609979 +   mt_doc_readmodels_workorderexecutionhistory    TABLE       CREATE TABLE doc.mt_doc_readmodels_workorderexecutionhistory (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 <   DROP TABLE doc.mt_doc_readmodels_workorderexecutionhistory;
       doc         heap    postgres    false    6                       1259    609992 0   mt_doc_readmodels_workorderexecutionresourcelink    TABLE     "  CREATE TABLE doc.mt_doc_readmodels_workorderexecutionresourcelink (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 A   DROP TABLE doc.mt_doc_readmodels_workorderexecutionresourcelink;
       doc         heap    postgres    false    6                       1259    610018 %   mt_doc_readmodels_workorderjobdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_workorderjobdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 6   DROP TABLE doc.mt_doc_readmodels_workorderjobdetails;
       doc         heap    postgres    false    6                       1259    610031 )   mt_doc_readmodels_workorderjobnotedetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_workorderjobnotedetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 :   DROP TABLE doc.mt_doc_readmodels_workorderjobnotedetails;
       doc         heap    postgres    false    6                       1259    610044 #   mt_doc_readmodels_workorderjobstodo    TABLE       CREATE TABLE doc.mt_doc_readmodels_workorderjobstodo (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 4   DROP TABLE doc.mt_doc_readmodels_workorderjobstodo;
       doc         heap    postgres    false    6                       1259    610057 -   mt_doc_readmodels_workorderpickinglistdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_workorderpickinglistdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 >   DROP TABLE doc.mt_doc_readmodels_workorderpickinglistdetails;
       doc         heap    postgres    false    6            	           1259    610070 -   mt_doc_readmodels_workorderrealizationdetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_workorderrealizationdetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 >   DROP TABLE doc.mt_doc_readmodels_workorderrealizationdetails;
       doc         heap    postgres    false    6            
           1259    610083    mt_doc_readmodels_zonedetails    TABLE       CREATE TABLE doc.mt_doc_readmodels_zonedetails (
    id character varying NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_dotnet_type character varying,
    mt_version integer DEFAULT 0 NOT NULL
);
 .   DROP TABLE doc.mt_doc_readmodels_zonedetails;
       doc         heap    postgres    false    6                       1259    610144    reportedquantityproduced_view    VIEW     �  CREATE VIEW doc.reportedquantityproduced_view AS
 SELECT ((data -> 'WorkOrder'::text) ->> 'Id'::text) AS workorderid,
    ((data -> 'WorkOrder'::text) ->> 'ProductionNumber'::text) AS productionnumber,
    ((data -> 'FinishGoods'::text) ->> 'ItemId'::text) AS itemid,
    (data ->> 'UnitOfMeasure'::text) AS unitofmeasure,
    ((data -> 'TypeOfFinishedGoods'::text) ->> 'Symbol'::text) AS typesymbol,
    ((data -> 'TypeOfFinishedGoods'::text) ->> 'Name'::text) AS typename,
    (data ->> 'OperationSymbol'::text) AS operationsymbol,
    (data ->> 'ResourceSymbol'::text) AS resourcesymbol,
    ((data ->> 'Quantity'::text))::double precision AS quantity
   FROM doc.mt_doc_readmodels_reportedquantityproducedhistory;
 -   DROP VIEW doc.reportedquantityproduced_view;
       doc          postgres    false    239    6                       1259    610135 #   resourcestatehistory_timeofend_view    VIEW       CREATE VIEW doc.resourcestatehistory_timeofend_view AS
 SELECT (data ->> 'ChangeResourceStateId'::text) AS id,
    (data ->> 'WorkCenterId'::text) AS workcenterid,
    (data ->> 'ResourceId'::text) AS resourceid,
    ((data ->> 'When'::text))::timestamp without time zone AS timeofstart,
    lead(((data ->> 'When'::text))::timestamp without time zone) OVER (PARTITION BY (data ->> 'ResourceId'::text) ORDER BY ((data ->> 'When'::text))::timestamp without time zone) AS timeofend,
    data
   FROM doc.mt_doc_readmodels_resourcestatehistory;
 3   DROP VIEW doc.resourcestatehistory_timeofend_view;
       doc          postgres    false    241    6            �            1259    609594    mt_doc_deadletterevent    TABLE     2  CREATE TABLE es.mt_doc_deadletterevent (
    id uuid NOT NULL,
    data jsonb NOT NULL,
    mt_last_modified timestamp with time zone DEFAULT transaction_timestamp(),
    mt_version uuid DEFAULT (md5(((random())::text || (clock_timestamp())::text)))::uuid NOT NULL,
    mt_dotnet_type character varying
);
 &   DROP TABLE es.mt_doc_deadletterevent;
       es         heap    postgres    false    7                       1259    610124    mt_event_progression    TABLE     �   CREATE TABLE es.mt_event_progression (
    name character varying NOT NULL,
    last_seq_id bigint,
    last_updated timestamp with time zone DEFAULT transaction_timestamp()
);
 $   DROP TABLE es.mt_event_progression;
       es         heap    postgres    false    7                       1259    610107 	   mt_events    TABLE     �  CREATE TABLE es.mt_events (
    seq_id bigint NOT NULL,
    id uuid NOT NULL,
    stream_id character varying,
    version bigint NOT NULL,
    data jsonb NOT NULL,
    type character varying(500) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT '2025-01-13 13:27:06.195813+00'::timestamp with time zone NOT NULL,
    tenant_id character varying DEFAULT '*DEFAULT*'::character varying,
    mt_dotnet_type character varying,
    is_archived boolean DEFAULT false
);
    DROP TABLE es.mt_events;
       es         heap    postgres    false    7                       1259    610123    mt_events_sequence    SEQUENCE     w   CREATE SEQUENCE es.mt_events_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE es.mt_events_sequence;
       es          postgres    false    7    268            �           0    0    mt_events_sequence    SEQUENCE OWNED BY     C   ALTER SEQUENCE es.mt_events_sequence OWNED BY es.mt_events.seq_id;
          es          postgres    false    269                       1259    610096 
   mt_streams    TABLE     �  CREATE TABLE es.mt_streams (
    id character varying NOT NULL,
    type character varying,
    version bigint,
    "timestamp" timestamp with time zone DEFAULT now() NOT NULL,
    snapshot jsonb,
    snapshot_version integer,
    created timestamp with time zone DEFAULT now() NOT NULL,
    tenant_id character varying DEFAULT '*DEFAULT*'::character varying,
    is_archived boolean DEFAULT false
);
    DROP TABLE es.mt_streams;
       es         heap    postgres    false    7            �          0    609606    mt_doc_embedexternalpagemodel 
   TABLE DATA           l   COPY doc.mt_doc_embedexternalpagemodel (id, data, mt_last_modified, mt_version, mt_dotnet_type) FROM stdin;
    doc          postgres    false    229   �      �          0    609696 .   mt_doc_managementdashboardpanelpositiondetails 
   TABLE DATA           }   COPY doc.mt_doc_managementdashboardpanelpositiondetails (id, data, mt_last_modified, mt_version, mt_dotnet_type) FROM stdin;
    doc          postgres    false    236   �      �          0    609449    mt_doc_readmodels_actiondetails 
   TABLE DATA           n   COPY doc.mt_doc_readmodels_actiondetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    217   	      �          0    609462 #   mt_doc_readmodels_attendancehistory 
   TABLE DATA           r   COPY doc.mt_doc_readmodels_attendancehistory (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    218   1	      �          0    609475 !   mt_doc_readmodels_buildingdetails 
   TABLE DATA           p   COPY doc.mt_doc_readmodels_buildingdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    219   N	      �          0    609488 #   mt_doc_readmodels_currentattendance 
   TABLE DATA           r   COPY doc.mt_doc_readmodels_currentattendance (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    220         �          0    609501 *   mt_doc_readmodels_currentemployeeexecution 
   TABLE DATA           �   COPY doc.mt_doc_readmodels_currentemployeeexecution (id, data, mt_last_modified, mt_dotnet_type, mt_version, mt_deleted, mt_deleted_at) FROM stdin;
    doc          postgres    false    221   �      �          0    609516 1   mt_doc_readmodels_currentreportedquantityconsumed 
   TABLE DATA           �   COPY doc.mt_doc_readmodels_currentreportedquantityconsumed (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    222   �      �          0    609529 1   mt_doc_readmodels_currentreportedquantityproduced 
   TABLE DATA           �   COPY doc.mt_doc_readmodels_currentreportedquantityproduced (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    223   �      �          0    609542 &   mt_doc_readmodels_currentresourcestate 
   TABLE DATA           u   COPY doc.mt_doc_readmodels_currentresourcestate (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    224   �      �          0    609555 (   mt_doc_readmodels_currentshiftsettlement 
   TABLE DATA           w   COPY doc.mt_doc_readmodels_currentshiftsettlement (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    225         �          0    609568 )   mt_doc_readmodels_currentworkcenterstatus 
   TABLE DATA           x   COPY doc.mt_doc_readmodels_currentworkcenterstatus (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    226   -      �          0    609581 +   mt_doc_readmodels_currentworkorderexecution 
   TABLE DATA           z   COPY doc.mt_doc_readmodels_currentworkorderexecution (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    227   �      �          0    609618 !   mt_doc_readmodels_employeedetails 
   TABLE DATA           p   COPY doc.mt_doc_readmodels_employeedetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    230          �          0    609631 *   mt_doc_readmodels_employeeexecutionhistory 
   TABLE DATA           y   COPY doc.mt_doc_readmodels_employeeexecutionhistory (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    231   &!      �          0    609644 '   mt_doc_readmodels_executionstatedetails 
   TABLE DATA           v   COPY doc.mt_doc_readmodels_executionstatedetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    232   C!      �          0    609657 "   mt_doc_readmodels_executionsummary 
   TABLE DATA           q   COPY doc.mt_doc_readmodels_executionsummary (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    233   $      �          0    609670     mt_doc_readmodels_factorydetails 
   TABLE DATA           o   COPY doc.mt_doc_readmodels_factorydetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    234   <$      �          0    609683    mt_doc_readmodels_floordetails 
   TABLE DATA           m   COPY doc.mt_doc_readmodels_floordetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    235   �%      �          0    609708 %   mt_doc_readmodels_organizationdetails 
   TABLE DATA           t   COPY doc.mt_doc_readmodels_organizationdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    237   5(      �          0    609721 1   mt_doc_readmodels_reportedquantityconsumedhistory 
   TABLE DATA           �   COPY doc.mt_doc_readmodels_reportedquantityconsumedhistory (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    238   )      �          0    609734 1   mt_doc_readmodels_reportedquantityproducedhistory 
   TABLE DATA           �   COPY doc.mt_doc_readmodels_reportedquantityproducedhistory (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    239   .)      �          0    609747 !   mt_doc_readmodels_resourcedetails 
   TABLE DATA           p   COPY doc.mt_doc_readmodels_resourcedetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    240   K)      �          0    609760 &   mt_doc_readmodels_resourcestatehistory 
   TABLE DATA           u   COPY doc.mt_doc_readmodels_resourcestatehistory (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    241   h)      �          0    609773 2   mt_doc_readmodels_shiftsettlementacceptancehistory 
   TABLE DATA           �   COPY doc.mt_doc_readmodels_shiftsettlementacceptancehistory (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    242   �)      �          0    609786 (   mt_doc_readmodels_shiftsettlementhistory 
   TABLE DATA           w   COPY doc.mt_doc_readmodels_shiftsettlementhistory (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    243   �)      �          0    609799    mt_doc_readmodels_shiftsystem 
   TABLE DATA           l   COPY doc.mt_doc_readmodels_shiftsystem (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    244   �)      �          0    609812 !   mt_doc_readmodels_terminaldetails 
   TABLE DATA           p   COPY doc.mt_doc_readmodels_terminaldetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    245    +      �          0    609825 ,   mt_doc_readmodels_typeoffinishedgoodsdetails 
   TABLE DATA           {   COPY doc.mt_doc_readmodels_typeoffinishedgoodsdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    246   �4      �          0    609838 #   mt_doc_readmodels_userconfiguration 
   TABLE DATA           r   COPY doc.mt_doc_readmodels_userconfiguration (id, data, mt_last_modified, mt_version, mt_dotnet_type) FROM stdin;
    doc          postgres    false    247   t6      �          0    609850    mt_doc_readmodels_userdetails 
   TABLE DATA           l   COPY doc.mt_doc_readmodels_userdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    248   �6      �          0    609863 (   mt_doc_readmodels_userlocalizationfilter 
   TABLE DATA           w   COPY doc.mt_doc_readmodels_userlocalizationfilter (id, data, mt_last_modified, mt_version, mt_dotnet_type) FROM stdin;
    doc          postgres    false    249   8      �          0    609875 "   mt_doc_readmodels_usertokendetails 
   TABLE DATA           q   COPY doc.mt_doc_readmodels_usertokendetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    250   89      �          0    609888 #   mt_doc_readmodels_workcenterdetails 
   TABLE DATA           r   COPY doc.mt_doc_readmodels_workcenterdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    251   u;      �          0    609901 +   mt_doc_readmodels_workcenterresourcedetails 
   TABLE DATA           z   COPY doc.mt_doc_readmodels_workcenterresourcedetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    252   PK      �          0    609914 !   mt_doc_readmodels_workcenterstate 
   TABLE DATA           p   COPY doc.mt_doc_readmodels_workcenterstate (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    253   mK      �          0    609927 )   mt_doc_readmodels_workcenterstatushistory 
   TABLE DATA           x   COPY doc.mt_doc_readmodels_workcenterstatushistory (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    254   >T      �          0    609940 *   mt_doc_readmodels_workcentertoresourcebond 
   TABLE DATA           y   COPY doc.mt_doc_readmodels_workcentertoresourcebond (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    255   [T      �          0    609953 %   mt_doc_readmodels_workorderbomdetails 
   TABLE DATA           t   COPY doc.mt_doc_readmodels_workorderbomdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    256   xT      �          0    609966 "   mt_doc_readmodels_workorderdetails 
   TABLE DATA           q   COPY doc.mt_doc_readmodels_workorderdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    257   �T      �          0    609979 +   mt_doc_readmodels_workorderexecutionhistory 
   TABLE DATA           z   COPY doc.mt_doc_readmodels_workorderexecutionhistory (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    258   �T      �          0    609992 0   mt_doc_readmodels_workorderexecutionresourcelink 
   TABLE DATA              COPY doc.mt_doc_readmodels_workorderexecutionresourcelink (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    259   �T      �          0    610005 -   mt_doc_readmodels_workorderfinishgoodsdetails 
   TABLE DATA           |   COPY doc.mt_doc_readmodels_workorderfinishgoodsdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    260   �T      �          0    610018 %   mt_doc_readmodels_workorderjobdetails 
   TABLE DATA           t   COPY doc.mt_doc_readmodels_workorderjobdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    261   	U      �          0    610031 )   mt_doc_readmodels_workorderjobnotedetails 
   TABLE DATA           x   COPY doc.mt_doc_readmodels_workorderjobnotedetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    262   &U      �          0    610044 #   mt_doc_readmodels_workorderjobstodo 
   TABLE DATA           r   COPY doc.mt_doc_readmodels_workorderjobstodo (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    263   CU      �          0    610057 -   mt_doc_readmodels_workorderpickinglistdetails 
   TABLE DATA           |   COPY doc.mt_doc_readmodels_workorderpickinglistdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    264   `U      �          0    610070 -   mt_doc_readmodels_workorderrealizationdetails 
   TABLE DATA           |   COPY doc.mt_doc_readmodels_workorderrealizationdetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    265   }U      �          0    610083    mt_doc_readmodels_zonedetails 
   TABLE DATA           l   COPY doc.mt_doc_readmodels_zonedetails (id, data, mt_last_modified, mt_dotnet_type, mt_version) FROM stdin;
    doc          postgres    false    266   �U      �          0    609594    mt_doc_deadletterevent 
   TABLE DATA           d   COPY es.mt_doc_deadletterevent (id, data, mt_last_modified, mt_version, mt_dotnet_type) FROM stdin;
    es          postgres    false    228   d_      �          0    610124    mt_event_progression 
   TABLE DATA           K   COPY es.mt_event_progression (name, last_seq_id, last_updated) FROM stdin;
    es          postgres    false    270   �_      �          0    610107 	   mt_events 
   TABLE DATA           �   COPY es.mt_events (seq_id, id, stream_id, version, data, type, "timestamp", tenant_id, mt_dotnet_type, is_archived) FROM stdin;
    es          postgres    false    268   �a      �          0    610096 
   mt_streams 
   TABLE DATA           }   COPY es.mt_streams (id, type, version, "timestamp", snapshot, snapshot_version, created, tenant_id, is_archived) FROM stdin;
    es          postgres    false    267   ��      �           0    0    mt_events_sequence    SEQUENCE SET     >   SELECT pg_catalog.setval('es.mt_events_sequence', 166, true);
          es          postgres    false    269            �           2606    609614 C   mt_doc_embedexternalpagemodel pkey_mt_doc_embedexternalpagemodel_id 
   CONSTRAINT     ~   ALTER TABLE ONLY doc.mt_doc_embedexternalpagemodel
    ADD CONSTRAINT pkey_mt_doc_embedexternalpagemodel_id PRIMARY KEY (id);
 j   ALTER TABLE ONLY doc.mt_doc_embedexternalpagemodel DROP CONSTRAINT pkey_mt_doc_embedexternalpagemodel_id;
       doc            postgres    false    229            �           2606    609704 e   mt_doc_managementdashboardpanelpositiondetails pkey_mt_doc_managementdashboardpanelpositiondetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_managementdashboardpanelpositiondetails
    ADD CONSTRAINT pkey_mt_doc_managementdashboardpanelpositiondetails_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_managementdashboardpanelpositiondetails DROP CONSTRAINT pkey_mt_doc_managementdashboardpanelpositiondetails_id;
       doc            postgres    false    236            �           2606    609457 G   mt_doc_readmodels_actiondetails pkey_mt_doc_readmodels_actiondetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_actiondetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_actiondetails_id PRIMARY KEY (id);
 n   ALTER TABLE ONLY doc.mt_doc_readmodels_actiondetails DROP CONSTRAINT pkey_mt_doc_readmodels_actiondetails_id;
       doc            postgres    false    217            �           2606    609470 O   mt_doc_readmodels_attendancehistory pkey_mt_doc_readmodels_attendancehistory_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_attendancehistory
    ADD CONSTRAINT pkey_mt_doc_readmodels_attendancehistory_id PRIMARY KEY (id);
 v   ALTER TABLE ONLY doc.mt_doc_readmodels_attendancehistory DROP CONSTRAINT pkey_mt_doc_readmodels_attendancehistory_id;
       doc            postgres    false    218            �           2606    609483 K   mt_doc_readmodels_buildingdetails pkey_mt_doc_readmodels_buildingdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_buildingdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_buildingdetails_id PRIMARY KEY (id);
 r   ALTER TABLE ONLY doc.mt_doc_readmodels_buildingdetails DROP CONSTRAINT pkey_mt_doc_readmodels_buildingdetails_id;
       doc            postgres    false    219            �           2606    609496 O   mt_doc_readmodels_currentattendance pkey_mt_doc_readmodels_currentattendance_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentattendance
    ADD CONSTRAINT pkey_mt_doc_readmodels_currentattendance_id PRIMARY KEY (id);
 v   ALTER TABLE ONLY doc.mt_doc_readmodels_currentattendance DROP CONSTRAINT pkey_mt_doc_readmodels_currentattendance_id;
       doc            postgres    false    220            �           2606    609510 ]   mt_doc_readmodels_currentemployeeexecution pkey_mt_doc_readmodels_currentemployeeexecution_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentemployeeexecution
    ADD CONSTRAINT pkey_mt_doc_readmodels_currentemployeeexecution_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentemployeeexecution DROP CONSTRAINT pkey_mt_doc_readmodels_currentemployeeexecution_id;
       doc            postgres    false    221            �           2606    609524 k   mt_doc_readmodels_currentreportedquantityconsumed pkey_mt_doc_readmodels_currentreportedquantityconsumed_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentreportedquantityconsumed
    ADD CONSTRAINT pkey_mt_doc_readmodels_currentreportedquantityconsumed_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentreportedquantityconsumed DROP CONSTRAINT pkey_mt_doc_readmodels_currentreportedquantityconsumed_id;
       doc            postgres    false    222            �           2606    609537 k   mt_doc_readmodels_currentreportedquantityproduced pkey_mt_doc_readmodels_currentreportedquantityproduced_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentreportedquantityproduced
    ADD CONSTRAINT pkey_mt_doc_readmodels_currentreportedquantityproduced_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentreportedquantityproduced DROP CONSTRAINT pkey_mt_doc_readmodels_currentreportedquantityproduced_id;
       doc            postgres    false    223            �           2606    609550 U   mt_doc_readmodels_currentresourcestate pkey_mt_doc_readmodels_currentresourcestate_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentresourcestate
    ADD CONSTRAINT pkey_mt_doc_readmodels_currentresourcestate_id PRIMARY KEY (id);
 |   ALTER TABLE ONLY doc.mt_doc_readmodels_currentresourcestate DROP CONSTRAINT pkey_mt_doc_readmodels_currentresourcestate_id;
       doc            postgres    false    224            �           2606    609563 Y   mt_doc_readmodels_currentshiftsettlement pkey_mt_doc_readmodels_currentshiftsettlement_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentshiftsettlement
    ADD CONSTRAINT pkey_mt_doc_readmodels_currentshiftsettlement_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentshiftsettlement DROP CONSTRAINT pkey_mt_doc_readmodels_currentshiftsettlement_id;
       doc            postgres    false    225            �           2606    609576 [   mt_doc_readmodels_currentworkcenterstatus pkey_mt_doc_readmodels_currentworkcenterstatus_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentworkcenterstatus
    ADD CONSTRAINT pkey_mt_doc_readmodels_currentworkcenterstatus_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentworkcenterstatus DROP CONSTRAINT pkey_mt_doc_readmodels_currentworkcenterstatus_id;
       doc            postgres    false    226            �           2606    609589 _   mt_doc_readmodels_currentworkorderexecution pkey_mt_doc_readmodels_currentworkorderexecution_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentworkorderexecution
    ADD CONSTRAINT pkey_mt_doc_readmodels_currentworkorderexecution_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_currentworkorderexecution DROP CONSTRAINT pkey_mt_doc_readmodels_currentworkorderexecution_id;
       doc            postgres    false    227            �           2606    609626 K   mt_doc_readmodels_employeedetails pkey_mt_doc_readmodels_employeedetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_employeedetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_employeedetails_id PRIMARY KEY (id);
 r   ALTER TABLE ONLY doc.mt_doc_readmodels_employeedetails DROP CONSTRAINT pkey_mt_doc_readmodels_employeedetails_id;
       doc            postgres    false    230            �           2606    609639 ]   mt_doc_readmodels_employeeexecutionhistory pkey_mt_doc_readmodels_employeeexecutionhistory_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_employeeexecutionhistory
    ADD CONSTRAINT pkey_mt_doc_readmodels_employeeexecutionhistory_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_employeeexecutionhistory DROP CONSTRAINT pkey_mt_doc_readmodels_employeeexecutionhistory_id;
       doc            postgres    false    231            �           2606    609652 W   mt_doc_readmodels_executionstatedetails pkey_mt_doc_readmodels_executionstatedetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_executionstatedetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_executionstatedetails_id PRIMARY KEY (id);
 ~   ALTER TABLE ONLY doc.mt_doc_readmodels_executionstatedetails DROP CONSTRAINT pkey_mt_doc_readmodels_executionstatedetails_id;
       doc            postgres    false    232            �           2606    609665 M   mt_doc_readmodels_executionsummary pkey_mt_doc_readmodels_executionsummary_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_executionsummary
    ADD CONSTRAINT pkey_mt_doc_readmodels_executionsummary_id PRIMARY KEY (id);
 t   ALTER TABLE ONLY doc.mt_doc_readmodels_executionsummary DROP CONSTRAINT pkey_mt_doc_readmodels_executionsummary_id;
       doc            postgres    false    233            �           2606    609678 I   mt_doc_readmodels_factorydetails pkey_mt_doc_readmodels_factorydetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_factorydetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_factorydetails_id PRIMARY KEY (id);
 p   ALTER TABLE ONLY doc.mt_doc_readmodels_factorydetails DROP CONSTRAINT pkey_mt_doc_readmodels_factorydetails_id;
       doc            postgres    false    234            �           2606    609691 E   mt_doc_readmodels_floordetails pkey_mt_doc_readmodels_floordetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_floordetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_floordetails_id PRIMARY KEY (id);
 l   ALTER TABLE ONLY doc.mt_doc_readmodels_floordetails DROP CONSTRAINT pkey_mt_doc_readmodels_floordetails_id;
       doc            postgres    false    235            �           2606    609716 S   mt_doc_readmodels_organizationdetails pkey_mt_doc_readmodels_organizationdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_organizationdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_organizationdetails_id PRIMARY KEY (id);
 z   ALTER TABLE ONLY doc.mt_doc_readmodels_organizationdetails DROP CONSTRAINT pkey_mt_doc_readmodels_organizationdetails_id;
       doc            postgres    false    237            �           2606    609729 k   mt_doc_readmodels_reportedquantityconsumedhistory pkey_mt_doc_readmodels_reportedquantityconsumedhistory_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_reportedquantityconsumedhistory
    ADD CONSTRAINT pkey_mt_doc_readmodels_reportedquantityconsumedhistory_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_reportedquantityconsumedhistory DROP CONSTRAINT pkey_mt_doc_readmodels_reportedquantityconsumedhistory_id;
       doc            postgres    false    238            �           2606    609742 k   mt_doc_readmodels_reportedquantityproducedhistory pkey_mt_doc_readmodels_reportedquantityproducedhistory_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_reportedquantityproducedhistory
    ADD CONSTRAINT pkey_mt_doc_readmodels_reportedquantityproducedhistory_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_reportedquantityproducedhistory DROP CONSTRAINT pkey_mt_doc_readmodels_reportedquantityproducedhistory_id;
       doc            postgres    false    239            �           2606    609755 K   mt_doc_readmodels_resourcedetails pkey_mt_doc_readmodels_resourcedetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_resourcedetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_resourcedetails_id PRIMARY KEY (id);
 r   ALTER TABLE ONLY doc.mt_doc_readmodels_resourcedetails DROP CONSTRAINT pkey_mt_doc_readmodels_resourcedetails_id;
       doc            postgres    false    240            �           2606    609768 U   mt_doc_readmodels_resourcestatehistory pkey_mt_doc_readmodels_resourcestatehistory_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_resourcestatehistory
    ADD CONSTRAINT pkey_mt_doc_readmodels_resourcestatehistory_id PRIMARY KEY (id);
 |   ALTER TABLE ONLY doc.mt_doc_readmodels_resourcestatehistory DROP CONSTRAINT pkey_mt_doc_readmodels_resourcestatehistory_id;
       doc            postgres    false    241            �           2606    609781 m   mt_doc_readmodels_shiftsettlementacceptancehistory pkey_mt_doc_readmodels_shiftsettlementacceptancehistory_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_shiftsettlementacceptancehistory
    ADD CONSTRAINT pkey_mt_doc_readmodels_shiftsettlementacceptancehistory_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_shiftsettlementacceptancehistory DROP CONSTRAINT pkey_mt_doc_readmodels_shiftsettlementacceptancehistory_id;
       doc            postgres    false    242            �           2606    609794 Y   mt_doc_readmodels_shiftsettlementhistory pkey_mt_doc_readmodels_shiftsettlementhistory_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_shiftsettlementhistory
    ADD CONSTRAINT pkey_mt_doc_readmodels_shiftsettlementhistory_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_shiftsettlementhistory DROP CONSTRAINT pkey_mt_doc_readmodels_shiftsettlementhistory_id;
       doc            postgres    false    243            �           2606    609807 C   mt_doc_readmodels_shiftsystem pkey_mt_doc_readmodels_shiftsystem_id 
   CONSTRAINT     ~   ALTER TABLE ONLY doc.mt_doc_readmodels_shiftsystem
    ADD CONSTRAINT pkey_mt_doc_readmodels_shiftsystem_id PRIMARY KEY (id);
 j   ALTER TABLE ONLY doc.mt_doc_readmodels_shiftsystem DROP CONSTRAINT pkey_mt_doc_readmodels_shiftsystem_id;
       doc            postgres    false    244            �           2606    609820 K   mt_doc_readmodels_terminaldetails pkey_mt_doc_readmodels_terminaldetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_terminaldetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_terminaldetails_id PRIMARY KEY (id);
 r   ALTER TABLE ONLY doc.mt_doc_readmodels_terminaldetails DROP CONSTRAINT pkey_mt_doc_readmodels_terminaldetails_id;
       doc            postgres    false    245            �           2606    609833 a   mt_doc_readmodels_typeoffinishedgoodsdetails pkey_mt_doc_readmodels_typeoffinishedgoodsdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_typeoffinishedgoodsdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_typeoffinishedgoodsdetails_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_typeoffinishedgoodsdetails DROP CONSTRAINT pkey_mt_doc_readmodels_typeoffinishedgoodsdetails_id;
       doc            postgres    false    246            �           2606    609846 O   mt_doc_readmodels_userconfiguration pkey_mt_doc_readmodels_userconfiguration_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_userconfiguration
    ADD CONSTRAINT pkey_mt_doc_readmodels_userconfiguration_id PRIMARY KEY (id);
 v   ALTER TABLE ONLY doc.mt_doc_readmodels_userconfiguration DROP CONSTRAINT pkey_mt_doc_readmodels_userconfiguration_id;
       doc            postgres    false    247            �           2606    609858 C   mt_doc_readmodels_userdetails pkey_mt_doc_readmodels_userdetails_id 
   CONSTRAINT     ~   ALTER TABLE ONLY doc.mt_doc_readmodels_userdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_userdetails_id PRIMARY KEY (id);
 j   ALTER TABLE ONLY doc.mt_doc_readmodels_userdetails DROP CONSTRAINT pkey_mt_doc_readmodels_userdetails_id;
       doc            postgres    false    248            �           2606    609871 Y   mt_doc_readmodels_userlocalizationfilter pkey_mt_doc_readmodels_userlocalizationfilter_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_userlocalizationfilter
    ADD CONSTRAINT pkey_mt_doc_readmodels_userlocalizationfilter_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_userlocalizationfilter DROP CONSTRAINT pkey_mt_doc_readmodels_userlocalizationfilter_id;
       doc            postgres    false    249            �           2606    609883 M   mt_doc_readmodels_usertokendetails pkey_mt_doc_readmodels_usertokendetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_usertokendetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_usertokendetails_id PRIMARY KEY (id);
 t   ALTER TABLE ONLY doc.mt_doc_readmodels_usertokendetails DROP CONSTRAINT pkey_mt_doc_readmodels_usertokendetails_id;
       doc            postgres    false    250            �           2606    609896 O   mt_doc_readmodels_workcenterdetails pkey_mt_doc_readmodels_workcenterdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workcenterdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_workcenterdetails_id PRIMARY KEY (id);
 v   ALTER TABLE ONLY doc.mt_doc_readmodels_workcenterdetails DROP CONSTRAINT pkey_mt_doc_readmodels_workcenterdetails_id;
       doc            postgres    false    251            �           2606    609909 _   mt_doc_readmodels_workcenterresourcedetails pkey_mt_doc_readmodels_workcenterresourcedetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workcenterresourcedetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_workcenterresourcedetails_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_workcenterresourcedetails DROP CONSTRAINT pkey_mt_doc_readmodels_workcenterresourcedetails_id;
       doc            postgres    false    252            �           2606    609922 K   mt_doc_readmodels_workcenterstate pkey_mt_doc_readmodels_workcenterstate_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workcenterstate
    ADD CONSTRAINT pkey_mt_doc_readmodels_workcenterstate_id PRIMARY KEY (id);
 r   ALTER TABLE ONLY doc.mt_doc_readmodels_workcenterstate DROP CONSTRAINT pkey_mt_doc_readmodels_workcenterstate_id;
       doc            postgres    false    253            �           2606    609935 [   mt_doc_readmodels_workcenterstatushistory pkey_mt_doc_readmodels_workcenterstatushistory_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workcenterstatushistory
    ADD CONSTRAINT pkey_mt_doc_readmodels_workcenterstatushistory_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_workcenterstatushistory DROP CONSTRAINT pkey_mt_doc_readmodels_workcenterstatushistory_id;
       doc            postgres    false    254            �           2606    609948 ]   mt_doc_readmodels_workcentertoresourcebond pkey_mt_doc_readmodels_workcentertoresourcebond_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workcentertoresourcebond
    ADD CONSTRAINT pkey_mt_doc_readmodels_workcentertoresourcebond_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_workcentertoresourcebond DROP CONSTRAINT pkey_mt_doc_readmodels_workcentertoresourcebond_id;
       doc            postgres    false    255            �           2606    609961 S   mt_doc_readmodels_workorderbomdetails pkey_mt_doc_readmodels_workorderbomdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderbomdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderbomdetails_id PRIMARY KEY (id);
 z   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderbomdetails DROP CONSTRAINT pkey_mt_doc_readmodels_workorderbomdetails_id;
       doc            postgres    false    256            �           2606    609974 M   mt_doc_readmodels_workorderdetails pkey_mt_doc_readmodels_workorderdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderdetails_id PRIMARY KEY (id);
 t   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderdetails DROP CONSTRAINT pkey_mt_doc_readmodels_workorderdetails_id;
       doc            postgres    false    257            �           2606    609987 _   mt_doc_readmodels_workorderexecutionhistory pkey_mt_doc_readmodels_workorderexecutionhistory_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderexecutionhistory
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderexecutionhistory_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderexecutionhistory DROP CONSTRAINT pkey_mt_doc_readmodels_workorderexecutionhistory_id;
       doc            postgres    false    258            �           2606    610000 i   mt_doc_readmodels_workorderexecutionresourcelink pkey_mt_doc_readmodels_workorderexecutionresourcelink_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderexecutionresourcelink
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderexecutionresourcelink_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderexecutionresourcelink DROP CONSTRAINT pkey_mt_doc_readmodels_workorderexecutionresourcelink_id;
       doc            postgres    false    259            �           2606    610013 c   mt_doc_readmodels_workorderfinishgoodsdetails pkey_mt_doc_readmodels_workorderfinishgoodsdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderfinishgoodsdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderfinishgoodsdetails_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderfinishgoodsdetails DROP CONSTRAINT pkey_mt_doc_readmodels_workorderfinishgoodsdetails_id;
       doc            postgres    false    260            �           2606    610026 S   mt_doc_readmodels_workorderjobdetails pkey_mt_doc_readmodels_workorderjobdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderjobdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderjobdetails_id PRIMARY KEY (id);
 z   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderjobdetails DROP CONSTRAINT pkey_mt_doc_readmodels_workorderjobdetails_id;
       doc            postgres    false    261                       2606    610039 [   mt_doc_readmodels_workorderjobnotedetails pkey_mt_doc_readmodels_workorderjobnotedetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderjobnotedetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderjobnotedetails_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderjobnotedetails DROP CONSTRAINT pkey_mt_doc_readmodels_workorderjobnotedetails_id;
       doc            postgres    false    262                       2606    610052 O   mt_doc_readmodels_workorderjobstodo pkey_mt_doc_readmodels_workorderjobstodo_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderjobstodo
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderjobstodo_id PRIMARY KEY (id);
 v   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderjobstodo DROP CONSTRAINT pkey_mt_doc_readmodels_workorderjobstodo_id;
       doc            postgres    false    263                       2606    610065 c   mt_doc_readmodels_workorderpickinglistdetails pkey_mt_doc_readmodels_workorderpickinglistdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderpickinglistdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderpickinglistdetails_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderpickinglistdetails DROP CONSTRAINT pkey_mt_doc_readmodels_workorderpickinglistdetails_id;
       doc            postgres    false    264                       2606    610078 c   mt_doc_readmodels_workorderrealizationdetails pkey_mt_doc_readmodels_workorderrealizationdetails_id 
   CONSTRAINT     �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderrealizationdetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_workorderrealizationdetails_id PRIMARY KEY (id);
 �   ALTER TABLE ONLY doc.mt_doc_readmodels_workorderrealizationdetails DROP CONSTRAINT pkey_mt_doc_readmodels_workorderrealizationdetails_id;
       doc            postgres    false    265            	           2606    610091 C   mt_doc_readmodels_zonedetails pkey_mt_doc_readmodels_zonedetails_id 
   CONSTRAINT     ~   ALTER TABLE ONLY doc.mt_doc_readmodels_zonedetails
    ADD CONSTRAINT pkey_mt_doc_readmodels_zonedetails_id PRIMARY KEY (id);
 j   ALTER TABLE ONLY doc.mt_doc_readmodels_zonedetails DROP CONSTRAINT pkey_mt_doc_readmodels_zonedetails_id;
       doc            postgres    false    266                       2606    610131 ,   mt_event_progression pk_mt_event_progression 
   CONSTRAINT     h   ALTER TABLE ONLY es.mt_event_progression
    ADD CONSTRAINT pk_mt_event_progression PRIMARY KEY (name);
 R   ALTER TABLE ONLY es.mt_event_progression DROP CONSTRAINT pk_mt_event_progression;
       es            postgres    false    270            �           2606    609602 5   mt_doc_deadletterevent pkey_mt_doc_deadletterevent_id 
   CONSTRAINT     o   ALTER TABLE ONLY es.mt_doc_deadletterevent
    ADD CONSTRAINT pkey_mt_doc_deadletterevent_id PRIMARY KEY (id);
 [   ALTER TABLE ONLY es.mt_doc_deadletterevent DROP CONSTRAINT pkey_mt_doc_deadletterevent_id;
       es            postgres    false    228                       2606    610116    mt_events pkey_mt_events_seq_id 
   CONSTRAINT     ]   ALTER TABLE ONLY es.mt_events
    ADD CONSTRAINT pkey_mt_events_seq_id PRIMARY KEY (seq_id);
 E   ALTER TABLE ONLY es.mt_events DROP CONSTRAINT pkey_mt_events_seq_id;
       es            postgres    false    268                       2606    610106    mt_streams pkey_mt_streams_id 
   CONSTRAINT     W   ALTER TABLE ONLY es.mt_streams
    ADD CONSTRAINT pkey_mt_streams_id PRIMARY KEY (id);
 C   ALTER TABLE ONLY es.mt_streams DROP CONSTRAINT pkey_mt_streams_id;
       es            postgres    false    267            �           1259    609511 9   mt_doc_readmodels_currentemployeeexecution_idx_mt_deleted    INDEX     �   CREATE INDEX mt_doc_readmodels_currentemployeeexecution_idx_mt_deleted ON doc.mt_doc_readmodels_currentemployeeexecution USING btree (mt_deleted);
 J   DROP INDEX doc.mt_doc_readmodels_currentemployeeexecution_idx_mt_deleted;
       doc            postgres    false    221                       1259    610122    pk_mt_events_stream_and_version    INDEX     f   CREATE UNIQUE INDEX pk_mt_events_stream_and_version ON es.mt_events USING btree (stream_id, version);
 /   DROP INDEX es.pk_mt_events_stream_and_version;
       es            postgres    false    268    268                       2606    610117 "   mt_events fkey_mt_events_stream_id    FK CONSTRAINT     �   ALTER TABLE ONLY es.mt_events
    ADD CONSTRAINT fkey_mt_events_stream_id FOREIGN KEY (stream_id) REFERENCES es.mt_streams(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY es.mt_events DROP CONSTRAINT fkey_mt_events_stream_id;
       es          postgres    false    3851    267    268            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   !  x���Mo�@�s�+�\�X;���[�TH(J���*�6R�
�q�aSѢ&��j�����H^�H(9��� ���`Q����E���bx�j0|�or3��n���/~0��x;�����|�	�͟���ͅ���������[-$ Z�:#DJ���^`i�ܯ7i}{��.�����߯���OQ2zV��5���Cakc�9�ᏞR�@@5@5Rr�meXJk΄���Zd���U���xy�My�;��M���f�þ��5�N3P�NeEL���Y?�>�?ϖ���K���T��f.�TB�� $��p��m��]Ք��S�Q�I�%)XwF;6�@Δ(s���	���q�Y]��������!>W���S��h�Bs����Ǚ �����=�>�������_vT�����W#!*���ާ���%��Ǻf�C�X���Faz�o3|\~:^LJ?툾m��b�Ɠֽ.�gI �ձ#��	�wYE�
�}^�-��ӯ�WǯW�_u�r�&�P_UB���?U�~�7c�x?      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x��[o[G�ǟ�OA`�f�~ɛ��HF�X�4����C�͡%�I�G�%�~��~�yݷI��֑DQ���r��'�d�HvW��;շj#\M��A��,Z/����T�2}��G��G_���=:X²��^7==>ƫ�������}�Ǉ��R��r2�^���%?�So�bv:Oe�����·����y.�{���r\��y��������?��ċW^������t����]���Wמ�2}����"�'�r�/���.˦�u�o8��2?���q���9��ˋ�W��K>=.�iy;���)���4�����,������<Y,��%Κ>+�e�/n8}u�l����ѓ������<;���黟�'���l�<����oW�9m>Z6����q�ڧ{\4O��%���_}7�^j�Q�ԋ��l~�OH���l}����8O�o�W^���tr~�WWYُ���tp�����{T����[�ǄdJJ��	�3����O�)�?�����prR^ח�X>��o��J˿&�g�s���R����ǳ�r��맯?���zS�7�r8[}i_N�G���3ɥi>\��P_*��Vci�Տ9��UY��h�i1��ŋ��f�/�(�峗��L|d*9r�7��$3�K��Rw !�F�x@X�F��
a{0_Φ�����G�|��,�P�"U�fQ]���R�:�>Z\e�8�^�sE�Y����@�khQ�h�ZT���G��2����t>-������vt�t%�AɒY
�%H)�(Kd�+�#TgD����1xH���+�@�bɃN@LQ�[�* 7�3�-��ƈ�:�I$ν��IJ��[�ԔN��fOY+堘�Qy-�bY�4�E����TC*!�;qKj�NpK����ik��t�je�+91�FM����B
's ��-�x�m�qK��]1��Q*ǳ
�v��
Iu�[T��8���[���D��4U2�{Su��2��R�����ܢ��7��Xq�����|���?���u9N�V$;�X��l��Z�
X(�<.�,511�\��~W1$��:a1U)��X�Q��}K��Q]%�x0�u�u�e�,�7���;��	��x�9R;�յ;�0�ª-���j/��7E�����aFH��19�f�x`W��E��F�/�G���˱��,�g�ه�� �mr 7IHi�nL�Ȏ3،���O��0��PS֠�Q������-�欯!L1 �oS5p�_,~�q6�T�Md ��!��:1U&�W���,�d:4nr�3 HL+Q�9��ף����1U+��K�>��ׯ�~󬝳m3Ag7�-)m�͈)Q;�Y;�:H�0�L,��ގ��J$JԮ	.�bֳ�び��,U+���,�.P�~R����)�w0z����ɛv�ځ�t�Z��5DM�8u�8X��t�&��M*1Y:L��|�]�mv*�d�k(�u�M]�~ctk��9Kj�N8KU����p�U��jU�4T�"�DUJH�b�7�s	�g��Y��n�p�~6=͎�j��()�u?b��F݌�ձ���ڒ��Tȁ�P����,����>(/t�n=�@1��o�R5��\?`�#�\J[t�U0`v5��s�
u��n66>�,m|�U-n�&�o<`��%jྍ��ǣ�˧�׿>�~{RU;�Ӝ<P�j���F5�祙�S͍ʪĲQ�i3��4G�b��U���
�x16缍_��:����l`'�w��e��H���`c�Z���M�-�a�� ZE�uj��b< �� �j��kG/VNN��&#ſ0���S��h_D*�LArϤq�i��B����*�l�%m�����7�c��.�N;�Ⱦ��[�G������ `Q
�{�'�em?RZ���G�^v��>����T'W����(��7�F���D~#��x r��L���c�ܽ�J�`7k����qxɱ���-��,�&Q9gU��4(�79�Y��_�]S�x�^T�N>����#6�����`�ZvB0�������cjBz���.�0p�0a���c([�ӿ�`�&Um�?����߼|���k��>�z7�Gj�n�E1`�
��Šs�L�f�inV�V�Y����إ��7v����+�{�6	L�`'�v��x9�x�R5Ȉo��b:p˂M���9��cׇ��x�^T�/���h�Sx�*��)7D��8���i���Q�U(�pϴL�B�Gݕ1�^osC0��oxQ5��=�\g�c8�`���ն��Sp�*�M�����KˍV[ȶ�F�T�j,L�5�r�lP\F_x1a�m�`<����j`3o����|.J��<�T�n2�=;��]��m��
�Qj��)��;n�.`�\��b<����j��Y�ˀ�9�ᛯ^!Ħ'���_@.��[���}Iq������0��	A$� h���dmN����±V���[Q٪���#����E��#LaA͒����z��BY�&�L�_(-+Eg]B��r���Hm�	��jx|�c�MҖ���B�U�	���5�kS����TlW�g���OG'�8��h2�?�x�8O�gG���j_��ilI�o',�zz�Yf�\+���x����7)htX��%?2X���r��b<���,�j�z6��z�_Z;�nO����I#�w �j:՗&��[��Q����x?0ʏj�9� �7��X�;8jf#�8�j����_U����W�	`��u����YWb�8�v8��F�3K�:�j��Lc0��s����RC��C�(����8���p�oJr��MF��R3��a�8_��Ԛ��=����`A���n���͙�֔X�p)����U�*8(����Y(M���e� ��ڌ-�%�,*���D�5`2yαlN���>RuB_�6���$-cA7	�IXm��F���CZ'����7}�X�����v�������M� ���]a,�<���ު"އ=X�rĻ[����U��~c���[�ȓ���vh=ز=R�:�ե�V�1*���%�,І�XĨ�%��@-�V�� �~C���͞�{8��f6:x����'��Z�����v�1��ݬ9&�v����"(k���S�Tx���b�Fe�	,W����Y�)���/�~}�-]��C�g�Ա��LD��Ze]�!{�s6b��f�Eh�����$�Y�	����/�6��g�_=9=��	>�p���ݤ_'z{���4*���CҸ�,���h֜K�|V�ŐoL��o<��<�j`�g�{���?!g�~��7h^�X�JeZ͂˒���l�
b{��>Aj���Si"0�ڊ���P�^$�BK�Lʂ:�Jz�[q	����a��+�h>hGp��څ�J�\�~AeA�WYm �9+���8�dC�`�ds~�v"ziu���[�`�U�a�MZ�̇�h��B0�y�m�����D��8��XKηq���J&)+���j�7^s���*گMS���T�ʒ����M��*�	��� ����Z�}�)	�9-ooعa1(��O��z��x X�F��F��~9�H{0���r����|bP�6T9���Δv�f�����ɫ~}��T|�(�j��z|�{0\�u2|����~3����[s����}���&�H��L��@��D��Zdb���7�w��&�CԶ*%*_OpS�b��XTl��p�Q*���CD��2�4~�Xk%�6��pGcxjRs��p�#��θ�}���ˣ)���0�V ;��yY]�k��H�_|_�S�?��ه���ɃT�n�>�q���q!�m�����סYdP����3d�ΧG0(�o�Q5p���w���N���_��g���fh!U��4zD�8���sk��B��̕(�3��n��X�T�s�WSe���b< ���j�.�5���h9�|���M˻v~������$ zw��j��0.�SL�\��YL"2�m�~o��z�~��_T��5z���l��lEĘ(�������wcj��$�� �� �  VE͔n��p�̀���N6�蝸q0,�x�X�1F��5Ɩ0�}�,�f��9����p���(p�:����S:����J���1s`���X,�]x�ҒJ����T�U��S�<e���b��N���n&H����<�c�1[g!xfl#� 9CI%V�K9���K:(�O��S��y�����h��u����l�gZc �T��"M�6g)7���|���9ʼӎ�,�/߃�-7��}F��� `Q
�<o��F�D�2qI��	q�z�{E\ %�	����i�w}/=gI��A(o$R�����T��`vܚ0f�����|�M��쿪,*�\�d]��Z�Lj�N�K�Î׌-^oa	��3E&�D햬��PS�h�NA�k�R����T�*p�f�Z��;ڸ�^۸AR��%���c��,�%���ՙ�X�x}�M?$m�HC,2��!��/���c����TY�]M9٘d�luf�{jW��Ǔ��]�`<����j�=��B-Ώ&���~sM�8F�Yɴ�.�7)1�s1&��f�R��J����H2�	;�0H�������Lv&�%�K7�cDE�]��؊���hJ���[��s�^iI1��o�R5@v���]�M�.Ɛw�-�բ�wX�Ӡ��]��Jc9R�n�ߙ�HM��Bw�8v�v쬔zg�:cM5��V�3k�h:D�I>iuq��z��`<����j���Wp4y?�_;y_��w8�o��Oi�n���q����m�7'��L�=0�=o�\`����;sc��~ぼ='/Qw�o-'��D��Cl�kO�w��¢SA�Am�����mv��0�� ��Ҥ����׶qhW�.��_��cZ�ļLx?n�3[���������-U�N���#�i���|����mK�; w{�F�&Qp������?���Ȋ=p      �      x������ � �      �   �   x���1O�0���WDY���k�N�J���te��se�IP�"E���#T��څ�޽w��YP���!,F�&R*K���X���|0e[��syS�Ϫ�ſ5�\����,�]t��*NGL�*�S���a�s�G��]2w��g��^�'t�����f('P�z]�떊��JJ)�� ���%��C�N���n4���$�bT·��-�6$�ք���Ҥ����4������s��_I��������Z�y��ӵ�      �      x������ � �      �   �  x���KnAE��*Z�������� a����E����ȸ�]��,!ʾ(3����,�Z��w[��[="r Z' S"�XFXp"@�@�}�	Ëj���g��=�Ƶ�e�M5_t�뺭�����j�\��k�ʏ��E׎�٧��>?�8���ZTL\��vd�ܞSzv��ǈa<�nF�?�.���������xڜ�����"a�Y�-�,C`���D�L
�}&ϗ�c�8�d�� D`�0��Ŕ�����9Q>��r/�B���Cݴ�7�|��z�*�D������q4�35Q � ��X���Z�[�fC�D�ךt8���}g�L���
��b�Z�
��K�#mAa�lR6Z��{R"�CyW/��/�<@�h��(��f��@mrF��{

�s4����
����8>�W��t�Ye�.E^����V��0#�"�ZI�M�DI
�R<���S��e�����I��}$`��p�Q�����K�@�M���&�.���(�I�Xऺ�~�U�~>>,�P�έ���ߌbRdx:8:Z�(�y]�t��CH2�`��j[�❞Yt디\9J&��Jf����Z�z"��H���ci{�����`��`�8�*/N���X�]��/_��"��l�1b�:���!p�/B<4�\�6$��)E%g��M�x7!���c�0(�{:_G���7�.Q0      �      x������ � �      �   E  x�͑�J�@���S�l넹���NEJ[h�e&3Sm����S���	U)�iq��{����Bh%)# *'�# H)l�s����^�{�LF�?Ü\���޹�?m��������Qt;�l�֊���y�0����]0�'5��ou�6����ʷEZ�;%"�^i���D`?�H&��1�')�Cp���:�j�c�P�@#'PA��$�*=�K��E���(�#��&2K)�8�4���.��U�	�鎣<k�ۆ�׫7���6D3�$���f�oA�8
J()���ş|���o0�^����9w�� �#g2���4��O����      �   �  x�͖�jAE��Wm���]^�`�o��~���H
���l����l��1'`�,��6��ԝ�)J�@KD�B&�L
�719ǌƎ�Lߧ��dZ��o&�S���;�xr���|/y2���~�H�o�â���6��b��;���m����î�Y��5�ڛ ���^�C�7�>,/x���]�vQ2r5HH��Q�V���s�P����H
i@ ���:T����D�����ys�U����l�r�:���m^sۭF8�%���$Q@g�@�: Bt�!����?�n�׷}�G=�C]v�ʱ�*�>f�Qg�*3X1i�g�����=�,ٕP�,jւ3���R
��1�-�!�=���j�����Ƿ�~Nz-��T�QR5�k��' +-䬓�tazm-0ޣ�����	� d[@�E�$�,�C�OZpʕ�ͼ�S�O�������M̈́T� ���"�҄���;��%L��F;����1/Ó�s�G?�c}��}��b���@f���bs!�0�6􁤱#p����kȤ�3W;^Z�-m��A��r��y��P�]�d�Ua��R����!p�D�8���ġ�[��y6y���"#��f����bH�����3D����r���j���z����4|-�z� �g��Ԍ��_O'�      �   �   x����n�0E��+"���/N��H@%*6;~�,%��ӡE�{�����xλW�)�"H��QМ	M�:�eٴ�AѨ�J��T	Q��eBr���|�u_?���C���=����v�=�p�r	��ur4�r2v|�#v�Onn��n^�E�
ʀO�W<��< +^.����#Jm�Χ��w��{�x>lp�����4��?�Db      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   Q  x���Ok� ��ɧ^[����8衇���m���d���J��L
ca[�F�����>�P�y�k���c��b#��9au�+ 2:��EE��0�'�^�n�Y�^W�i���뻃���&Y0@����=Ѻ�M�"�ai��MuނerL؆�c; wnW5?@�}�Ɗ���7�E��o{���Q�m�1��Cn��\`.��H�A�y2��`C�6�[�P�@e1�|�
�%a[^f�,-q����3���t&η�!�z��m�1ex���T�:=��:l����S���
�BR��d�\�>8m�fץ�>�W�u�n��4��S���T��      �   �	  x��]o\����_a�6��!9C����[#6P ���+*K�%M����'����v}�XI�`u��Ύ���w�P5�VDĸѪ	���I�3{�F��Ͽj�Ϟ=�������?��>�ч���}���{{q���w�o������������c߿-ח�7�X���ί��^\_��Ͽ���w�0�������_��^��~s�����vq����_�}�W����=�#��x��S��������|8���w�c���.��o���G��y>2	��3k���7�7]��L������/o>�p��~��7O��]we4�TلZ�)�f��� Ųs�~
�oO��s��_\�����w_�ǌ2�D�M!�QAɘ}�E���(Y�6�&��&��&g��i���I����l���p�R���W]�V��D���`�;H���ЍPW���-����bGw��4��	67S72s��\�ǁ9;�9s�'�&g��1TC�R5~`ނ�j�;"KjL5ר8#��dS���rfG�ޚX.L͙�b6�5O#
��lI�g�>�Q��l�[X$Xw %c���c�B2=F�d5j�����*�7
[����m�^��ӗG1DJ�'s�LL&�_cC�����C�IS[�!1� �6�\��q[���Hsl4�3�-w W�z�%�k��H#'�b"ӄQ��U3T��z��p&{��3U=#�%�G%hPjä��g��=gK����/��,଒Uʦf�ՠ�d/�
Q(:8���I�p�-�:�=n�`���U��(R1"�8��s7��3Gm�<��ܚɱ��d)tj}�ْ�����,�r�/˙�?���n��g��z�`�%�\���,M��H��3�Rr���B����"�u[*��ҳ%�ۜ�<�tg� g��I���y> �� �����Bu��Aa8� ����Z?/	�h�X����g#�h��������Ґ�x�Ysz�8_�%����*����E�u9�}�5o�%�"؊`�و��s��E���3���Z�z��6\�����M� �SJ����=gK��7��\���P�H{�nR��C�JXlhRj�C$.�4WJ5�O
g$Yx���)��I�r��ʌ�ބ��H��m5�Y$��,7��1�͂��D�fJ�P�T�1�#��,�&���F�ߑV!��cR�w��"9e%����%���B����Y[��}��żڒa]�VJ7��4{A?wq��`��゛sI���yT�̧T����8�8�b�pZ�αdP�=��eo��<� n=f���M�Y���	j�M\�N��-G� xG�^-��x�<,&��҂L�%N*��Kd���r�� ۊb�1mX�l�`�k�!`��L���J%�0��Ğ�QB�N��Jg[��,O���j�OER��Z�	^ P�`zҘ �\�d��ۄ��ߵ�v��_�0j��G��s�v~.뜜Cj�C���4��ni�b��>&�I.�lI�G�0�?��@��܉���O��A.P$�L��L	�!��j7`D�z��a&�"��}���<g��jª�l%��a��H@������f�6�-�Ѱ	;����Y".y�M��(N�'�.Mp` �����I��'�>@G��P�Q2RQ��PS(1.{�	S��)�|׋CQ:/r,Ỉ*��R|Ð:m?{�������Bx5�+TOui@A
f���:=%�"���q����SJ8]��p���2��6�i���X���EibkQb�%LRCx���l_P�Hd�b�F��T6�$x��o�|��5�Oi�1�|��ߠ�(��d�]Á�~D�{F��C�n��5��{W\=���96̣���|Ʀ%�$x��?Ծ?Y����v�)lu�� ���,��
,z�p��[��BB��	[�Mثy��1Jv�}�rdk0�v̤��dƈ1J��o�w9;)����b�p����Yܜ|`i$\�^K�C�z?�G�U��?7t� i�HQ�o<ْ�]Ovg��'gv�µ6,���BZ-^��#��"�O2]7����J4�Z�IP�۟��ՠ�	2W[.b;�dR20�0�3�CZ�B�t�Z��4jϟL��4�u�!L1��{�c�'�{��͹�bl�p3��x���t���Z�'����7إy;^n�M�Q�x�@���)�F��*Nq~��;ZQq�j�l2�RS�a�\ɶ��K6�߰ x��w�O�t�V��8������X��hP�y��Q*�^�x���z=չ~oݤy�ʼ�����J�ƌg�^�,���n�B�N������Ȕ�8Vo-�E�D�Yc�	�s5��ʶ���J-	ޱ�Gma���-�G�u��C�R��/�	�6��G�@H�y��aD�k[͛RnI�'1u��[`*Z�$���w�nd���=㮌\��%WMe�z��_ա&�i���n	�0�<�ɽ���I�O�(J���B�Ox�����ӧ�P��      �   g  x���Ok�0���SH�.%o��ěR'�i���.I��Bm�*���k=��"��)���>�BdX�c1M �f!2d�c�5�}��G��^�w�p�7�����\<�m��mRϪ��m�;���tܘ�8��d9m�I2�U�m��?=�	G�>�#N",��� ������i���:�~��ϫ��+�zо������wg�����u^�=6���H�A̲I�1����F)�o�k�����}�+[v@W��E���"����xqk���f�dT"F�GF(��rA�W@��W�]��j{�H��%���8~���;�3��o
���� 3�H'�U��?�5p��J�"����\V�����-x�� �#@!�      �      x������ � �      �   j  x�őA��0�����2�l�Vn��B(i!۽�2�F�`ˋ�@C��DB�
I/{h�{3#}(%h!,���8!	p툪����R���^�l�^�x����,?��ٿ�c��g�Ӝ�׀�c����0�/)GA+d�X�(ix�Iׁ#��u-5ZȜz�f��#�Sʟ��:�%B<�Tc7����.��C�1'���0�7�`_�=x8�>&�'�f�m���S�'�u#mbDo��<��Xp����z��5o�MS1.��+J{�!GC��\���!�r�	#�CX��r #�֚4�T�t(����;�X�c�ey��?!���/�\ ��HzyNK4v6}��m+MC��o���|/z��B=F�_��(~��[      �     x���KK�@��ɯXr];�d��G��ED/��Y�!�zP��XE}�]����u�c��߅$;��!��gs��î�?���]�8��?⹌��:�L����2�oF'ɣ&�LZ&� D* �P"����
]��C���Fi☭��\dPQ18������ֳ^��2���x�_�麟��˸�3O� 
)Ap� ��1Sd����:�4� !wB�>�*�K�=b���ΌСS�|@�:0iI�SvX�xnدE�v}�&O%�0�W�D?�\w�������� ��      �   -  x���[o�@���WD��k�~A�C��&�RJ(�����cR��w�HiD��%�Ҏ���4.�	Q.�)�qD�h���-��~6B�h]4\q��Ec�W�ԏ�Q��-����r�#��.�u��#����-'�I�Iw��z>(��K��[��9�w��Ӽ���,ީ}s����~,G���f���ol�Ȯ��Oe�4���-�M��&yVZ5~�0�@�@��E�� a�/!�mL�6I�(�rݗ�076-.��s����$-j�NE$�pa@)��"!1!)(��U��Į�r��D�Dހ+��ĂXi�	v��҇����^ʣ�}��n;����ۅ����=��<���{ո�b���	|xh���A�q@5�@j�sP!^�"�
���-x���/,]_����l�
o���[��qn۶�D�Aj����@�y������.�ygo����qh�O�_�����qôe�~�[��׻�w�T?N�0������7z�ލ��ݡsK��ns�o��A���O�W�[���*��	jA@�%Qg�����ߝ��W      �   �  x��][o[Wv~N~a`��f���7�#���`�M��k�R�i�i0/�#��ڷ��WזF���9Jh� 
}�Do���뾷�p5)L-��>�h�`6Vk�S1������Ͼ=3�g�4z�8.M���zq�QY�M'e}r����Q^��'q����M�p������㸘��}��E{��"�z���?>�~1/�Kio��-ˍ?BZ/�g݃�'�Y��螼[� �������O��}Y-N���U����Z,���^9���V9����نp���-��We�.�����^����Of�?}!�4�&�H����Z���NI���/��j��@�j�q�!����Vϻǿ/k��V_�/�L%G�X�&3�df��2]J�$D�WXS�7�ރ�z1��r
�����͛~p�c�����e;p��"���g֫�t��@�W#8c(w�-Ex��.NQ�e�����|^F��_����~�U�IqP�d��
R�,�Y�J�������<��L�խ��jq�A' �(��H�����Ѫ1����p�E�s�n�Ʉ�����>����PQ���)k�s;�"�E@P,�`��!��u`58�jH%��+��TD�c��{3��Z��JN�{�Q��0�⺼��� �hI���<�2[T��sR?6��i�RU��z�5>���m¡J&|�{u��2��R����:|)��_����h�,���)B|G�_�n���ސ�kY*ࢬ�*n[511�\���l����Y*ܻ�,xQ����� h}�2�)u�5&��8K����d]fӛ�����E\.֋ӳ~��9�'��hd��Y��`8���
�:�G��AЪQ���x<�l����������ӏ��P����O�%�P��5a=��/�m5Nr �i%
:�b�]D@�$쇓xI���n�Ň7�����=��r��'B���h+� >jL�M��R'pw$���%�l���.!o��V�e=����I����搎`��������O��NI̟��n�N7ֆ`��3�TmR�ɚp]�a�W���N��L�?Q�XK����|4>R��5A�F�Z�A����p(hk�ʈ��5��f1_?�>�D�C��6 ��ЖK�Ɖ:��jU�4T�"�DUJH�b�9A�.��:�㏋��h��!"��Br���7F��J!�5O�3P!�BE}X-Yp13���B��Ѝ"<�9�'>���b�B�s>j��[!h�b�#Q3�B� p�U^E�b#X�_��cCO�a}�V��|dU+5�ij�psi�j�㥥����bȖ�2�H���F#(·��
�xe���9�����@sbɊ��-�6|���R����Jg��kvN�<�,�VQ�l���"(�7k�P����h2R�+ÏgC��������$�L������PYeF�%]c�>��)n�W��a�i�\ٗ����3y�([�0 � ��t����	9q����GH��Tзcnp\�a���*&��Ks�
U�M�1A�� ��:A��D1�]�f1��g��XZ�������D�U)"��J��њEL"����5������V[$�����8����v�t����)G���3�)L���h�j��P��sD�	���7o��[?�}��'oC�'��BEv���.�Ǽ��s+ZV�Y���W�������6�,�1�8C��6 �!a�oƦT2�ꤘܲ`Sf���jL1��'�0V�������P����p� ?cTv
C��1�M�B�WW�Ѥ����~�g��F3�`bٗ� �}���h�����m 6c����5.�k����J�٠����bB7�A���3]^�S&/���m �~T��bg�׶zf�FӒ1�	���0��`�� ��*^n�6~������������r}`��o��VQzj8:�;�CbP�l�m��FY�t{����*b�1��_	Q٪������K!~B8�{�UA͒Ψ����7�&�u!+`�
�Ȍ��J�0Rͺ���e�����	�3HT�wL[�MB�Z0���ظ����a��E��\і"�I�_����hy���f�SX�&���ǳ�y:?�"�{h��_X{gDl7Sյ�v̝1zPywT�-4)h\:Iвmڙ6QeW���*�l�#�|?Џ�Pe9�|A�Ѯ�6�4����e�bA��6�X3>�|Ex��1����ᑟ糫�����<�?<���{.��T5n�7�c�3�Ybk#�$:gq`�3�h4Qj��$��a�?.�d��&����E$��������v��=�"�E�dU'ݼ�`������KQ]�hU�����V
���΅���D������g�F�n�+����o"z��I��ڜ0~G�b��
�Y*����j����$,���25�#���S�7Y�Ͱ�j����ΩEDM��X
�\*�H��{ۃ�,G�1����E�֤i�Ku��GW� fT��܀���B��b�|Ѣ�$�"��K-(·y��0���÷�;x�j��~'� Ub.A��6 ��4�X9��9�Li1�e�BVM`�
����vc�"�_���^>�����sD�無��0g#��5�Y������$�Q;��m��ջ����������@=@Tٮq�&4���3�t.Q�2���g�]y#m�_�6�?�]���:�@h���Qj�izpY2��MQ�@�櫙�>�]�ի����t���rfRČ+��Y�h!oU�Q�����Ǌ9cf
�!s�P1tO5�s���F�vd��vZ)�Ш�vC��]�D���b���m��"Ub��K���P}�)c������܇��6Tc���R�$ee��,!\��͉��Ӫh���(�=��V�|d���UG;��:�Id��Ю'ӸaЭ`��0�	����)���&���".֣ڨ2�D�RO&�H]bO�}��� �Է�1��]V9����M?R�7�{�z��l�E�hj�����[x��Ĳ��liWC �9����1��K�(��<��� �RuD�Y��XZg��Fm-��N�;�/���+h�K�Jp�M�7/�jr:�t����FO�rq�7~r��
��8EHU�6h��pN�A�^�5(:�В�*��z`���9����"|����|��y|t���=e������a3����Z�����]Vd�Dឩ,u���&U�\q�ՔD麹Ỡn��l�^B>KgG�rԏs�-⨉���v�s�ep�ɜ1��YL"b�l�@&z�q�'E����������Y���C�7��J��6p뱐��4��1w�L�V�ŋ�*I�l��;�q��"�+��0_�NV���`	�l�-�`�f+8���}I��x/�����~Qǌ�^��)@��%���gJ��"b@j;�Y�-ԠU`��k�6�����&-֥�KI]~G��m�a�����a@,�E�Z�i�;8d�q�.�is���V���H�r�|PҚ�!���:�^zΒуP6n5���x���6��=��*ii��;2B�g&����;'�wI^�*���`4:R�܆�fl��æg]��uSd����JVbu��T4��N��#E���{�y-Ӌ�*	y��#?�[���TDwM�dcR�%��E\�m�UAe����7&1��[Ƀ�bu>��ʃF�P9p�z���zoRb��bL�`�^7�!�Z�D���8��rL�����������߆�
�i-~O�f;� ��k�1�
�粫;Q���_����ټ��˽>s�E�p1��v��c1Bk�DL�-G��5r��fC�EQ"�ېӎ1��2jg��0Y��J4oS����VSѝ'����|��~Z�������g��DH�����Ԃs9��Fc-�g��.����q�&E������20R������������9�H�mH��^{;�0p�.�ц��.ܪ	31�B��Z�����Ex���[]������������tH�3�8�@�t�����_~��rp      �      x������ � �      �   �  x��[M�%7]���h��Zv�>��",�" � �Dae&�ߩ���h)Ŵ��U�~���N�>�l_��z��P�\�I� m	��6����_�w�z��_|���i���?~����M�뼾��;�����g���w?����#��?};?}��>?ٽ?��n�������y��P���"��UL�SzO�4��Cx���t|;���ß?W�����1����u�'�o�ۂ}�J��q���9{Њ���"��Y:�;��bQ�/�.�QK�$�	4���*0u��,�&}���,��ҽt9�HG������-�PCZ�t�G��E:x�t.Jwҥ��(_.]^*�.��[ӪP�9ƒ��K:x�t.J��D����E���:|^�4'�:���0d�^��7K�t'����W]% i]6�&��T�j]Ӌt�f�\���Ĥƫ��P2��U)��v���QZ��xu�w�W�;��Ș�d�N}IOp�b�Hm���C�,CS/�����,��ҝtr�����%n�Y"�0I���;Mh�
rђ'_� �6X�;��3>0�hS*\�V�@uEh5*ĕRD���+�p�w���ҽt�>�u]��:
���ۅ���&�dI�7�z��{�z(�I��@D��&*Y�^4��0I�U�1��S(\��ZW1��6X�{�bIR�u������f���$����
+Z���&~��&�NW��t�����<>�M̰'�2�\'���C�N�r�8>�q"%���Y��d+��TJ��M���&<��Ӡ���gn�rxd�>�-�(SC�Je��&<��kNJ7�q8��9=��s�W�0Z8�	�24�d���!_���,��ҽtź�<��]��n��)js5ȼ,!q	}i�-�Zsr�wGb�;��(��_.��Vh�`��\xg!�$�(�q�1q/�y���sQ������t<��2��)�d5t(�L�A�b�,�ք�{k�C�N�t���I��J�.H�Y��b���ŀ-�0�\+'���;���X8?X�P8t�	�{6s�J�+�c�M�֫]x��z(�K����`���Lb�D�?j���>�4f�$�^�o��E�^:��N����J��K��C�[˵����$F�j�j��]Mx(�I���t����	YK;��^���}�9Ǳ�|���,��ҽtR8��n�9��5M�&�Z<���Kkܐ,]+'�f�\�#2�>�u��iFm�G��H�ʫ�P��r��a=��#��1~�tm��\`V>�N6W�h�¤}T�6�<��ҹ(�Kǚ��:�3ǖa�f�%(�1�"�������H�t/��˃p2�k� �����Z�V"i)[�3^�u?�>�9(�I�G����u=�!�̠Ҭ�[H�:�I[�ͤ���x�;��W�=�ı<p�bV������N���'�X��u�+�x���	�{�82��ud�'����de���
�I%Z �7��^t�P��N#�zO:�j�l����C-�܉ �B���A��o?��t']>�E���l���h�hH5�g����vI� ��C�^:�BO����3$��yR�p5�I%Y�̽v�jXx�\�t/��æ���2VF���\!̴(�6�N:y��kX����އx��<	'"�t���Հ�Y���J��(�^�y���sQ�����C�'�a� �,��͡�9ah�}(�I��&<���y(�XE�'��f�qM�0t�g6�y��$�����V�"��{3�C�N�rXr��`���e��ϣ}�d�IKYg2f����^�t7`�9��'G��)ΐ!������S������<�݋NJ�6�ӓ��n�vTM�c,+dJ��c&iѼ*˫�����C�N:<LZz�J�'�X��Dg�ҙƵ R���M���=�ݑ�C�N�t��<8�*�T�D,6MP� �Z�oD�s���7K�t'�M >���z�A�6�))�l�J5O=�Ztr�wX�{�Ԋ	~r �&.g�x��p�1�[�1I{e���J��8&���� ���<��Α���0C�Tm��xI�����P��#Rx�딅W�u+hΟ�F�iN�Ps���n�%��[:�;��P-�Μ̡��A�<���ux{��t}�1����	xw5�t'���ܓ�:z,)Y��Z!32���5W\^�n��>`����BO~�����۷�=8Sh      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �	  x��[�n�]K_Ah�Ԡ�_��d*�C��M?�i�2�&��mv��+5r̹�{Iv�&ZJ���9]u�TM_�آ����b��L�jj��������O�ŷG/p����^���l����~:�>�)����O'�����?������o��:�����#�؆*�Q����\.D1���#��c<?��W��=�T�Ŵ ��Y��,Cc��8W���ߟi�(4Gh�5�[e���[��Rώ�����rz������>�(�����X�����3|�B��nM��IL^C�5hkM�m��=b����xy?��ƣ�.��s��xs}^>»��yy�wO`���	��k���TR�L�������O�N���k��+��(�"~��L�	��D�������c�{��]�G}l���|p��j�MA���'��e��dJQI;��>`|�_~������a���|p��u��RK@U	�$r�������L�CN�!Z9Y�.ⳒK�ABű����	�-�#��_^�rtyqvzd:b?1w�]{���y�b�<�-�Mg	S��V�_�0�u����59#%H)�NU��LQ�غ�e��Ƈ#�ŏi��{vyu��˨�]z�*	�('��C K@K���	�/>O^�ձ�]� SA�tl�$y<�j\b�*܂?b|�ߕL�o���u���A5����Zԣ�.�&9͡�-R���B.��oQ1�E���y�?��g����듻p���)� NZ�au��J@���Q��eIr�H:+[��ڗ��-�#Ƈ�~%s����.ܣ�o�)wP&��R��,y
�IpXc��6���8ϩ��h�f6�g�����bm&m�5k�N:�T!�	���l�E]a6J�/t����τ���=m�x����6D;�Gn5sS�و�%[βo��C0.P���ws����?�X��˨���H�2I�!�*e�k �P<'W�sѤE�>�����I?��>��j�TIQ�)AO��HN�Dè/-\�5�i5�
�>ψcE�����*�'��V�K��?�7�����Q_�ƾ�X�3�+k(���A�.��#J��	$�D%�\�[�`#Ə���r�z�A۪u���^]d�S-�X�N|Z�FR����H�V�eQ�#ƻ��\�Y<����+�~���E����ӓ'߿�����M�`O>�hc� [�^d�U���Y���O�N�09Q���W�br��Fj���&��7���`um��7s���g�M�KWX���|{#�����ׅ���;p��8�,�jQl��y��)J�H9i�?��T6b j��5$DSd奷��;p����^���Qw[<kO̫�cD�r�d.��f�g�m �j�����e<6`| ������ۮڎ��-�,Ga5�g�5�y��0i4)E775^;�d_��}����v�q����w�D�fuYP�~�~&�V�/�_&�#��}��_��5U�n�O>y���z���l�}K�rВk)c�X�-�#��!��IG0�ko
�V����Ӎ�%*B�9I�"j�9pY$�H6��{�xh�зR'}/5�i���EQe�Wr�l��h ��h���w�|?TP{~y�������֓
����j��ֵ�H2��N��s���)6r�|_1>\P��םn]~S��dĭ�䓝�ϣ�b�G	|+�Z���2�1~dLs�l?�+꨷M'6�N��z5�s� 3
rdQl�)`Ҝ�V����i��?r {�w�����Q�SEj�Z�-��\�$�b
�ۢ�G�G�4m������o���6��d����Ggb�rV���d[HUZ�����/���g��=���p��g���j%�_l���#��@�.��,$��t�;�>b<to���W=׌z�|71!���Fh�r*`���C����IP�)�m���z����{p�m{&���[��Z7�l��ܜ8--�	(U�s�Qi��?�3�uJ]�4������j�gV�c��J�ʬ�E$�$�<G�G4��O#Ƈ���g��{S�Ao��MO>�hRmY{(j~Kc5D�2`�P�'Vy���>��{5�ew5r�Ǧ�����$>�-H��$Ab�t)�zv�ĴsY�q��f�RG���L�<�`�9gE�y˨������Ɲ���Ə�B5{!�_u�i�Ku�LVŴ5�k���KA�JEkAa�ܚ���1��]�角�޶�\yB�n�5JfӪVru��܄Z�gU�n���"oF�w�}�xys����_'��m�U�"�x�o�rI�����s�"��|��ȫZ���4�p���8������Qw�V[5�S�����b]#Jzk	aUD(�NgT���l���	�|���M7�y�C�5��o�8M��ߡ� ĉV��ܾ�)�c�o��7]�r;b�X���|�S9�>�֕������kԚxByU��C �$�	�aZ~�0b��]����]�Gl�N0�ʬ�5��?��U��      �      x������ � �      �   h  x��V�n�0<�_�{��o�7(��a�^T��YI�AQ@ݯ/%�I�� �Jh����C�2���Q>�e���/�Lgey�B �k �!� ��)!	���ɳuŽ˕�l�a`�9�-�z�_�Zy_�J?�2����ԝ��u�Q�8�KA�b�2�:Bwz�{N�r_RW\��)" ew�wkT�U����cZ&	ŌwcxR�m\�BR<c��7v$�BByBX������5��ڢُ��Gx�[eM[x]iS�����q>�{Ri���m�h[	);�eim��X��D<��f�
����p$�Z���Y� �X���[�U�ؤ�k��.o2���0���^���aF��DP���E�\����x��e"�Cu����LI����V��T��4Bp@��d�E���̇�ĥ+bP��z��,g����cB|�c)@Ĩ���j}�[!������e���w*�dm>z[9�[��$#{���r�P{U�-f����5i�*i��-��c/F+E�p$ l��)ƪa: ��ݼ�e�-����KY���n��,B��>q��65Ǭ��l��E.2A��ݟ�-��X�ny�i�^�B�?4�`n�8��w�ďd2��k���      �      x��}�n\G���+̴;��~10�-�U��$�]� F\U�(RER-S�z)�|D�?�gަ�_�vRRF&O&��b��dTd�{��k_C��"h�J`2�Ĵr��S�I-�3I��_�>8:��5S�"��gZ�ļ��%o\i��d�q�_��[��j�1˿���/�W���,���ON����1}�~���[-�T|��٫tt�q��Q�?ۏ����ZnH.�	�'�W�}���+�՗����on߹���g�x�A=�|x��	�u_З����|���o~}�{�io�'n���n�.L�`X�B��-W:��m���I=f�ژ�)̶��nƲ(ScAɠ"W6��mܘ�+7�f�x�gG�!^��	�$������Q��s�oN���-1���������L�]����Ê��B�;L/?��􍹝��Į�~W�$g���J�M��T��vU~�~���O���~Dk<9�q�d7����O�����o��V�mkmo�=�Y�\H��%�����jm�>�����x���x�'����9qp���/�i=5G����g����t3����7��o���o_>���~����z�^:)+Zf�@k��<K�T`�''s��)��o�I>���_@��KV�Z+�ç�z�\��6��7��ʲ�l`��!9@���4Q��\B-��\}���͚��+��{<=;9��.Ѱ��R�vb`;�ض����e�Wб�)&���'�U簍!�h�`�+�ln�\:UKV��n��,޳_[�:���OW�n����aA0��eEڔ���z�	�)?y;��H�.*׏�����S�q�V��~V�a�$�g��*-d��?a?���U����?�;4��[�������ׯ��ý���w^�?�wG����E��]��s�Y���qh�Ts^*vү�U5�(�u0[Ѫa��&�4����6�d��5�2�������.�{�D+ ���� �N'ei��NC�Yދ���⛃ӽ��Ŝ:}����F￪Ϗ�?C����f)�x�_�������~_��Z}�L��;GG��?c�8�}�֛�R5��<:~����_������˯�͵�m�ߜ֓G�������?�t߿�
���Z���?l˰��sN��|&l+�����Zh�)���Ƴ���Q�C��O���訜0�D��g�d���4�?&�Qp�[����,���Q:�2�l�(��	}4�qz�fެ~��֓�S1����ћ�~�ǣ�c{��?��G_��a���Fl��-����w���I������)���Q�$��`o�C�I�p��W@�tf>�T{J5)J�E'�1�{9<ܯ�^��^���E������{�����("ѿ�@d/-�|�������j5��A�D�[5&�P���.|f"I_�+!��`�Y���X���␫����o���~;°vf���V�F$F�9K�H��7�UK��a-U����8L
R�>���5�&Uz-5by/�G�u,g�,�jY<����o��Q�X�I��E���M��K`���%&c��e+������]^��ؙ����w��#�Ww�����7��?�4�~�����C�Uo��}z����r���R�mP�)���Z棒�4zO�r��M���Rn⅖�~X���G�73�xd:	ɢW�����R���'��-�� �o~��??9�{����������������_��������>�?�;�����(`9���#��I$6 [L����!VA������ؒu��ы�^%^`Rf��Ʋ4I��G���'[#�HnX�z>[��̰X��>��Y��ĭ������y�!�K�W_5���p�$1��KH����9f���
80-�ͧ M)\�a�X����pGM���5�u�8B8SN�] �R��t�/�dc�N�r�E���]$�&��~��O�u%�<���\�RP&�*bP��'��	�a�X��r9��s�Ye
��&HfU6�y[���j�΀�_	=!������!�H�t��dj�����
3Dsr��̀R�(PVa+?݂V����|�bȥ��k�Z����z;�50 �m���lհ��B^�VVq�0`�`۝��w,�VM�K�En9m}m��Z��S/�g>���R����:+��@�#�A;8�tt���Tiq��Z� ]���\�d�i�������-�5��}�E��a�����3s�J�-�UE�l'5���P7x��Z� ��Ԛ�v�-\��#:t�n��PA�xS��� æ�Q3D��1�'�l4
��~8���bAzos��yD߻��z�� �
������	���e�[�bs�37����Y%>*���4�M[����6E��p��
}m�h�!:'��2�e	������4�h�!��EaB�����/��\�X�>�5fy���+�Xї�$�&U��x�hp� O�]¼��h٪[J�U���)�2!$e�_Rݴ��pɀz|�0�Mh�u��7�]���ʺP(�ۈ�X���kH���":����ɂ��e�����(��n:Z���F���F��]��QB@�W�r�কVxU�����1�u#|D�1��*5���tf
�x�6z0�pn.Su|T޼�?Ž����ͯ�ߞG�����uE#�G�2����o��e�ꠜ>�xNNs?Eڇϴ���'������%�>�>��ےyq�9^�Q�UUjoO�,_pj�R{j>�3�����Y���c�G:0����U�PB�~��N��f��G��	<^�D7�+@�I�V~�h=�x�r���F���`a+Oߝc�c���~p�����k �]�h��ER�`$?M�7��R������M�W�
��t@���M.�E8�vK�4krm�fB&(op��y͞s<���2���QX���# !p�G�d��1�0D?�Ҁ�l�r�ho�U���ǡpNE�.v:�x�k�D�!TS��������$�bv��9���ydi�n��/@Q����W����Pܠg�WE-`j�XKq�L�n�8H
�Z;����ڰ%����
p5Lӥ�Z�����q�o���z��͔��>L��u>�l��� mغ�.����Z틀�S���x���ӈ?��a�$�@
�y���HB���|1"5�e���9u5�(i&�����˕��.z��b3������5�J��+
���Tۅ����I<z]�|!�`)�;��?3�E��X�U``	��0���O�d�~LC�	�p��S\��5���/�p_��rUBw���fˎԭ�B�����»�������@���Oǲ	�G����0� 	/��jL�����[���i�(%wL)8���"��f�F�)��c5iU+XT51T��:�����D����� !A�c�}b��R-�&��F�6P �E�]}�W��IR��s��/�|��y����)=��i|��.�e��#1+�����S�w V�a^�mDTń�&�P5�fX�J�����zrb�A��(�U*��P�{��U���e�x��$\������z�� �ש7�L//2b20ӈ3��R�}��ʀv��o8�V����L�D?�g8�RS�<y�w�N�D{%�P��f8��2�t���áSbM^i狾��fKM�l�`kJ�$�"bY(��l�#�7��u*.ӹ��0��3���E�`"���Jc9 ���t������&H:tP�	s�6aC�\n#���������aYu��(�b1�y�8�Q�TL5;�r�U:g�Fj�ec��9�r��G�#c������D>s��ɅU� Zzhj��Y5��������3��L�l9h�X##��h�8a~��w/����G�s���{�=}�=��L�������o��-�P���\dN9�"@G&�vP~�B5���(]�α�\~FO�0qkdk����Zե����C8&�#3:��U�@�f*	�ZVҁ�\^����y���������TҘ�sIu�@]V*�Nj�2�,%Ϛ�\!b����vFU�qQ1��6�`�>MB    )�u`k� OOj��.�mF-&@l�֍l��*+�U��"���.�$[�]�S�����{�TxIQãfo���q��E¸ї'�>s�k���8k�o�]6�J.k�4�(���P#�S���:P /W�*,�(#�)�e.*�:��Y>���>��z�WM4T��zXIu	,8#�����Fk敬Қ��<zVr�i,� �D���2�)�T�D�"Ӈ�F,���|��@\������ZO��|��y�����5�$м.��R�p���v<�	X���W�S-����'��>���X��ۥ<Xn<}�3z�[h-5e�R��T���L�������WEl�^3�Y|����LU@���0Y���<޻9ѩ���U�ɳ�T1ᗨ)�Z,/4��#dF,��{��y��p/�L]�ϥ���4�N6O�c8U� �\f����pt��p����ցۥ�������9�oQS���>Ea�R���=jObI�Ȳ�z�4�,��P�/_ �y� z/�E}F���������l�xj���00ڔ;��j�J���r�����9�&d&pK����c�/8bK�������=�W�H~�	n�=��l��`QT��i�+�x��E)���3i�V����3/�c��c�����=���{-�k��p���	��R���n*��� %prO�D���h�YQ�S�ދ�>��H!G����X��*}���'L/��瞄Z��lM�����.������/� ���

���j�eG%ͩ�L����N������u��3�����ܾ��<z�sd�8����PW�I��g�ʓ��|"8��Wi:y���u�b���+�@��I�~��̦��l�K��y<�5A��J�k�`6,xl|����N������<���ޣ�O������{|u���1yj�;i6�Q��Q�GQ����,�ҜM�[�����{w��3/��?>X;"��p��N���̮����
/Hi� ��ZΌJq���뜼�м��ꢬnݼ���?.�����r��rpn����D��a���n�d,U����lׯ?.�{QT�q�n?� ����T��׊�ݒ�\'�B�B�ЃT��z41e���M*��.�����_<��G*L�f-�1NN��S��T�k��v
�ꊧR�u���Q�����t��[ԝ�'(��n�v6���n�L��"�+���Y���b�m�������������A}��*���)���%����8��qm1����BDj½5r��Dr~W��s�d+����i�K2�Z3/��#�������;E�7��rg%��z�����^<#����������W��Ջ��찾�[h�zx��b���^��	,h��@�f�.%��9��^�-�����%���U g�)���2�@��ӊU炀Ĭ�L`rQLz�XJf"4�n��lR��U���T_NQ1 �$�%�#�Y�vQE(AU:) ��j�Kv	d�GÇ�����8��Y��+	�-<ى�:WW�D҆EECɰ��_x[��3_�im�,XZ���������wE�4��]:9{�wrt������t��䮤�&�K9t����9�Z���1�TY��U�|�v�Itb�݂�e��*��iz�/��ɦ
w��C>?-��"-��;֝�+Y�mB����d�y�ZS}D�Ps6zٚ���'^ב�̽���q�w2t�Am��:�*�������[<P,���yab�7f*~��:�VS����gzԜ��r��Ef�m��D�hU^Ke ���J�.x��\7��V�i�y��{z��]�P�hG,��f���=���<C�+����Hg�ΎctQ:w����s�zi8�'ޛ04�m����F���8w�tǱ	6�sn�g6Up��uQ��9�@�xȤ�|X2ELẉFN���1N���v�#3�$]p3���98�*�c|$�A�
yDs �S�/��'���j"��N!���ʍ^V�rl���B)��:��d\� ����r������2�%]��f�|�
6w���z�#v_�]|��@�}T�B{
#��/YC-�#�Y|���$�B>)�/�qR�(��ɔdLTiX`S�hy,��X����]�J�dvb�le0��I�+�j�����z�$gQN�\a=�tI�1
�0����j�Y���K���Һꓥ'�954�j��"�H�U`�@� UTk��Y��_ͬ�R���Κ��Nh���@��ޛw%��|�{{T����H��﾿u��x�N�ah���!L�VCx�t	�a���z�J\'!� ���J�˵*Xy�TG5��Q�6ӭh�8��낽�bǖ&��v7���>�F�O��A_�@��d�<6��u�4�>�m)XЁ��ѓ�#4�Dvw�1A���.�`����4^���}o��2�#�>�s��A�Ҹ{N-�FF>S�0f��[Q7�w*71�[���{���Į���%Ex����u�6�G�"��b�T���Jb�	���v9��լ}�	^?n�&V(�w����T�[9�B�V��&6�x^'�$CW�7n��� Ҋ�uﺝ+?�Z��ꛋ�u�
�U ������C�� ��ש�S�h��(C�t�-MR���VL�$[j,�/��I��\��gu�Y�
��N���6�J���K j8^tIiHB�uX���}���=5��H(�%\7��D�q_�����E����u�S�	7�c;1Q��S�%{
�&�sK��8�gs�Hh�P��<�t6K�����wY1�A�@�5*N�Hџ^��W�8M\�&C�:���Ju�B�{w���lu�:�ST�f֩�����s���A/\��S�HKdu1���Х�H�n�Bv�i�܍W�������:�o�ڇ��g`��ZmR8z�2!B��,��S�i�1�{�<�/����r<~��ܫ�g�{y��?ON�����ӣ�g���x|zt8�����x8�i<}C}arN��$j{�Ŵbl�M��|�ְܧWw������{�l�V9����?�'Go���ˍ����t�#��	��:�3��`��94t?EX���h��j��a�"�����$c��Xs�M����,X���@�~�w|��N�N��:�_��+p��2�%8��o�����5��'V?i�v]�{��I�6'�J�R�C,kq�nX��RSR2Ӌ�!蘋a-�B�*j]F����EpŌZ���p ��3��(�NA�� (��r�>�0�Y|s��&���V�9L��UIA��.�͌�|��fyy\��tIgW��-˭�E,�(�sI5�9��u=����gW��,�}���4g�Lf�xh0�q�\���!GU�U/߻f�e(���PW�eh\f���>��|�"NG��I��Y�f���en�b$��5LJ�B����.=��L@B��
��ک�4,�:u��K�����Xu�Y�/��3|@L�]�h�SR�$ ��:���}�|A9�^]g�iu��)�b5E�/��]��Hk���J$K��MQ5UQ�PNf[q�U�?WM5��\�p!Ly��O�+H�^s�����4.�)jC�O2�b1���Ju�x�,O���t�&Xݍ��^0,VM�p�*�iI��Gy]��u���oM�\H��{A���U,b��vx=�:9P=���h\:�V�p��ILF�d�Y/�������s��������Nk�����^N�VXc�$��qjB�����]�dhaȇ����fYHG��Nb����{M.dk4��x�"�?�B�k�����gVh���f����{��싒E��4Ԭ��tr�B��WPA`�u7��w�VPB1)�Q��(�umR�S��g�<�dC�x�L�Z�Z��a��]�^b��v�m�b/�,L��F�$��;��M$B�-e�5�H0�P^F�����u�N��Y(�\6G7�*Üt�g�/��(�w�����n��?|~�*�izz�;�辣|�P	�t�nW�����*���Q�*J��D������{3eC�Bݒ���^�rF���U�(���ڍ
�k���pU2ZP�i�!�*x]k��,�U�-K�
'y)hڈ�~|����tG�T�K    u���C�n.��1�K�V-8:�^K�����:j3c���Z����E� βA�%.��*�<,�%�D�Y'���w�]06�$h6��$�'�m�)�u&��E��K?���x0�n[���<$���o4B�
Q��ʭ5�b
��������\do��R̬*��X��.�#��:�8���*�&X�P4�)%�u)�>�<f�\�/����/�ɜ�w���ó��GG�g������;׽[��>��du���m��<c<�}�L�А	��.��N�C��[�f�s�rZA�I����$�E�y��5��=`t/��W#�Y����ӣW�t�u|9��������|��{+����E WV�b�ܠ.�M�f(�!�^�4�ʵ3��BV�M��n��@��j`i��	�X�`;�t��彐ǗGo��u�ʜ�R!K���_[U�roe��W�]����z�� �ۆ�}'f��tI�D��T���Ɨu���� 1���V���Q�Q�����,���Ņƭ�ֹ%݄f�f������[Ӥxū����V�I�N��V%7,OOf���@Ȗ�,�ϝ�����;�U-׭H����g'u;�;V%5�aT�g8=��dD�-{�5��9XM�a0� ۤfA�4���z�9f�j����o��soe�߯�D�ڀA��6�oE�v``n�RpSi
��2���:%/z�;/2��2�f���Q�90|�	WqU�����k���Zli�N�c�<�Рi�q�n��3�,���e��߳l�	�Ӎ^�ب��H�V�����Y!��׬�
��h�j�R���O4K3���
_/�g�R���6����I@��R�z�6C7 JY.MR]��z�ƨ*5��ݐ��Y5
���� ��/�6BS5�R��ű�mI4���x�o�=�h��^���p��a�~�-D�BB#��F��2,��IJ_�Z3��,�>V%-���㣓w/�E����v]����׳�d�GD�xg�R�|tyÍ�"Mcr��f"�ZVhѣN�8�̦fi�BF,���Ww��������7i���'�VE����6~���'4�/hЭVd'�Z,w�p/i��x�Z���d]�!˄�����M���͘jl/��G�j���ݻ��� �3i����!w5��(���;#��B�Š�;�$웦oT�C�Hk�aY�oRQZ�C�c�h��i����W��e<���K�����]~w��۾����@�I$�L��bh��v"����4�+� 	Δ.Q�l��s>�U�
�Y\���q�V񐴥�L㲓����oo�槯��ߠ��А�����Н�H3MuL�E�D#4e�s��+�ìf�Yc�cK�Պ@ܷ��C~�{�/�Wv�`���-GP�>+qX�4��d��t)Pΐ�Sif�Yc��9��<��$���w4�ѯU�:BV](-IO7�B�Z<f˭�d�Z��ב�q��K��d�o�G;�Kj�UH;�Ԕ�Ӛ:BR]M]2��:�f�F	��o8Rr��Lw�����%�zztP��z�~b�\o�������2!�a�����5&	��FU�k���Kbh� ad�i���\�1E���G,��t�k������wW��W�:��`��ɀ]�Q���N�cdn%����dz�V����\1��C̜YO�5�An|�GtƆ�\'�1�Ǹ��E�ʙ���B}	,7i����]�8;��J�1_Me�i���6W>�Lv� ��*=�(�}t�y!��%�~p����tΨ������@�j"5Cw~nG������8�L�J��K�e�C:W�h��o)݌��H��ȋ���2W�8by/��țߞ��ף���̹��:��hqx*�&�� ���+�vN`.
#Z��T.��P��?��^4+�t�*��H�.e�R��[�Nu��|��`S������:ְX��w����±��}�4 rk�����*�}
HI:I�A��D>�oξ�3by�go�90o�����gw�^��U��3��=� �f�4�i�#<�΃,��g�E�kP�����vs�l��K�2٫%�ڷ�.��`�r��7�����Oã�n��O�=�z��]�`�i��Y*�2�m��l�\���<�f2]���ԠKq��h�'�c����d���������)5gkw�5C�R��a�o�X���Y���-8�^O���F8���F2ќqUU^K�F��t�uTN���������q���r|�6�Ϋ�+Ϋ�M�5]{�t0CY��H[���E!�RH[A[�1���*{i��G� Y��k9SsЩJ�%�e��|Nڧ������ˣ���1�-�Z\"���=���Zc�����6vwֆw��BS��t�<|�h(��������fE��V������p����M���|��g���L~���FQ�	��Q;s���b��K�i�8tG�EF'��f.����&Q�P�����4�2��`\�'�c�/3������ۋ���1����F�0:7���n�CU��qe��D�$T���,ؗ����%;�������
�k
��B7(�lj�7�c�/��Q���s�5�Vl"d�������s�J���MkTL4���fU�y���Kky��R�I�-L^1�P�@���;`#����d�v��"8�}��&Q�0�Nٝe�E���19��X��j��Xoa.�S�V�p��7��(@{�B�*i����ҁ1�/Fͧ����������ou�I���|��k����;��:����$�&�R,eW���=���q-�n����2	k�\ы�>e�}�G��ހ��������%�Y~r�aO ������q5<Wex>�s؂nQ7|Bm$bg�Sْ��ZX���Y�ȫM�����Tk�
n��F�d�JbY������1����ngu��Y|�;U�Đ��U Kt�j<]�@ES�P7+]���e�8gM҈֨$]�Jg]���i�N�˗螯�^œO �W�
�I��OW!�,1���u���4	7�&L*�85�̥�k�	=����R7�a@�&��|��i��LĲf.�B�����1a���Dq��Ύsp����<��E�kp�l��\
8霩@�K�����1��
�<f�(!��B��:ڰIS��x��QS��]��"����6dP���N2�܁C5�-\��%�Aq�|������Y>�xy|^$=�h�ޕ-�|�'R���i�#�~p���o*�,Z�Z�OZϓ�`Tq-V��f���oI� c����X~�.�?�g�G��rT!�&^��j=QZ+����x�Υ�$�u�N�ʚ��)��f:�p)�;��f�l���Á�ԏ]�����nG{p��o0�<[��fzo�<���*Q�g�f�;���hh\3_ ��R6�h�~!g62'j.N��}���,_!�O긽�vz+6a`~Bc�ͮR�Zv�:[g��M�9��sg��s��,�+�)&~HǐX���t��v��1˗�����l��8��|��a�i���?�ǫ����%i�����^����	S�ـY��Ղ���4���-*���ܹv6PϓgVhE�M�tW��7�����\�Y���8V|��7p�c��)�����R�W`����C��C��:J�L�G4!)��A���-�dl�������P!��@_Vh�z��@{E���]7�/痛�}��@�rgu�]̹�^�v���x����2��g�pﬣ�y|��=���IRý�s�c�����~�>>*o^���^�K�Է{'�N�Z^9���%��*pZ�.5� i
��˚��.'�z;�k(�����i�a��L]���������~�mr,+U��)=ߺU@���A���4"X�$HI��Ey�B�C��ˇP���y�v�D���Ju쵤oJu��M��S��>0ӈ�(Y�Mi�o���*�a����	���b��K�dU�y���Y>ׯ=��t��M�z��MB�n�e0�L.��;I�>@�Q(��>ep�Y=u�-F�ĪO49�Yv����#Σ��c���O-XE�:�
�u#oN���e�N�j�M��.E֒p�p|;��*��#��' �  @.x��0�:�+	��Kv��^���K
���}�������r��)������假M"L~�����#,���Xn��a��W��.���)�A;�`���Tb�1�,_x8>z�S����e����\x�tu���cZ;9���b"H;��D� |�g�F��R��3I̕����J��%�&É��1���,j－Y>:ƴZΫn\�5���|r*g��Ѯ䬺X�1�͵��V8yJ�\,�W��5S�"����X�lK�.油c���y��h:�jL�ѷ���<v@��ba�h�A����Kw$� �G��g�l��ļ�P�8a�%9�v<3�U�r)��ĎY~9�f#�B��
�Y���]��h|2E*�u��J[��p!����'<Е>��cG�El�+�$� �S橔�F~���E2�\b � (�&��*�W@��9�#�_��~2�RD>^�ȱ�q�q���"����K�w�!m��Kt�C���YR��87v��&F%�	,I�!0b^⇲�O��i�v�Y~9"?��\
ǧ��8���EM��
�!Vt�I�.x��"�+�~����������<X,G#�@ؽ�6� �P���xKK�� i���D�m���1�W�qՔ祝��V�%���;<�/�;���zÔL�q�;
�oN�j�خ�ٍÐ�L/ܦ�p�l�S�J'�\7�3�4A��GD�+�}�jZ����G,	ι�x������⯀K;q\�]ħ�.m�"�������6���ʵ��A[�K�0�����ST�c�0(�t�,_R�q���o�����_��p|�� c���ڙ �M��UL�t1=� 8^X�\ca|�1�
�d����Bs�d� ��V.�;���ss��,_�;��{�V�rU*�3(�A�vN���wv���c�����S��'�s�����?��ӧg'��3t#os�9[����E���EO1�,�A��޽�'C~�w2�����g�z�7�����M<���|��]tV��3}����yn�b�{]@M&A7ߺ�b�p��/7n�\���ʜL)S�pD�75�ր.`5��O���s05��Z�gg��+�/7�'��a�Ny)��(�o1�Y�8�_�5ݲ.�-c+4�Y�U5��߁Me�m�t��O�KӁ��˳��Į(�v噠Ic���>�/�q�-������Y��7���C/A�tg5�E�>|8oEC��*����'<�*A�衁��<�X����d&��*L�0�0!1m�L�s�N�3g� �Ƀ��4���{��,�����x������JyǷ��ٳ�����;L�1n�Nd;��H�M{>8�H��*�zY��[m���r��� �e��H�b<��������d�����)��s+��!���)%dx%�h�]iNYM.����Ñ��J���{�[�T���̪gac���~|DE?��>�Z�5�-��+��ΐݹ�J�C!��<�Rh�Uu���w4N@���41*����ʃ�K����tû�������>��g���B�� 	��A�� ݵi�&�J��Γv���F�a�r��k˔ÜP�rS���8��!eX@<՚d8,���D�;�7S��(J�k���-�J�!��5�����tY7�p�^vӫܡPD���PC�=��|����Ӟ͙OA�� a��m+���K���>e���9��[�I�
V��gtw�N3>�K�p�RŎA�i`�q��>���l�;��n���{�����}�.J���@��vv�s�TL��2p�e��t�+���ZC2u�p$Mu���������J���1fy�����˽W� 8���Z�������:���������+�ҘF� ���c�J;��E[�o��OK�108�4��x��c�z;b���?~W���u͒���i�Ξu^�*��%+�Ee,u1EK�[���q*�W´P݁�F�lTP�[-��!�t��!><�M�?m�o\���o����JM��ym+.�,�9_�7�}�Zz���)�À_���	{����Y>�5�Wݎ�O�1=�|W�v�]qC�8����M�2���;A�4L���+��@>�Yx��hsWߌX>_o}
���t�	Pwz|t�~O�����zNO��w`lc'���7����N�$      �   Z  x��[]�%�q|��yv��d���8r^��A6�b`�O{ak�Ю�(�>ŵ�r��b��9�.�]]E�������c�f�\Rw�4;�	�Q��eiCl-��O�7�F��Xg��'�ߑ��|�@1�����1��c~�����_~�������??���_��_��E�C�a��ل<�)ىq�{GQJ����_�>�\��`kņ�+f��
�[2>6!2IJ3�i��B-·\��!��3�������L�'�g�	�6S�6|Dj"���~{���Ih�=g�bIr��Fh�u��P��[��&�!�1�%q�Ǵ,�+�����'��F�Ұ~.GL&~$K�{�^[~��o��),��J=c�_�����>濘�B+���l���D�D�$Dm�Q޾��~�#�URL���y���_�o�o>|���O��ۧO����U+���sș��egm�޾�������ӣ��8�}�/!�薅{���K��Ău��Mk�Mu�u.�T�/���������tt�jRX�Z�~N�q����T�/\�H)r���s���eLA}���,����Fr��2~B^�R$���H�P�2��7�C���a�K���(ڴn�+��ǘs3qT���h2�a��l�$������m��F_1O!���r΂����P��8h�����;��-W�yJÎ��I��q|�J:�`o��H���s�=��1���>��3��PR6�FI
}T��|���1����3�)����	�Ս��X���$�m;����s
}��8c��@k�Mo0��)ԚI'�:G�C���ЈGp�Gkq�<�AYK��J��gճ�(��K��[=DѺQ/��4z�d���%Bi��,��>F[��B�9躳~G��D�G���aU����E1t����4�)�]i�!Ϸ��J��5�%����fĆ2�������u['�s���P�*s%�+�!�\�u*�����|Tݕ����ts�����`4�.J���1���[�������s��*mF�ft]lT�D��i�#h�
���&�m4h��Ok�ѐ=J�f����$`a��ے�S
�l&���9C,��6�7���n�g�S-w�<�y~X&�q/Fd�L���V����6y�<�`vH	E�駠J���Ď�kW�~O�Ab�K��<ߔ�|g$��\��O���꒕ĩ�k#�!�Cܮ�󔆴�t$��^`Hg�jF�d+�$��������+�3�y����hb,0~ɢ6+�br�̞�=�pp�ߒ3�ye��,_Ό�Q(Y��[��ZdO��b�����T�b�.������Ȁei-�|�{rX,�<�f��ٺ�:T��F�IZZfP�e�B����6'8�s�UB{<���	f1���?�nT���v��!�(v�6ENc�����AFG��v�ӾK�b�щ;���w��H&�*��)�$���j�e�3��~�<`y��k����
s���i�a�)��ۼ8�������:l�<�-#�k�c�+~ ��J���\Ģ�����YpI�O�=Gk��yP"_��~As�6�2p��u�\0g.�������_>|�h��ed����عK
^#�ԑj���}:=���I=�Y��9ck�]�c�QB��	5��eDƔ*���d<,�[��j����4Me�Jm�մ�zɔK��wX�0�w\ΘU/ATS��v��6�*fdn�33��i�;T�Nj/��}����u��1�� y8��r����p�q��Yp�!�"���z��ɞ���j�W�$�־��Yiþ(�H#�y2��nŌ��Sl��B#���1��{u#�3{� ���zFF�������x��v+A�6��8tr���c�Z*Uo��i���3f���Q݀qD�G���C��F$�a����T5A��n
<`V]Tehl�m="��y�&��!p���r1�=ۯ���<٭#V�fuZ�Vjwc	��T������n;Ϙպ@X�tlO���X1�m���'�~'����U�3f�eHI���}��溌�
W�f�Y���a�l�㮘�d�KS�T�~Ɵ�	P��A1�s�x��ފ���=`V=-!8+��Q��9�K&&���vx�;.P18ݩ�f5�Ac�nH�,�����R
َ�)�V�ݣ3f��CC��F7/�Zv���Êe��J��KD1�]�>`V�@;T�kFPCf�wJ��.�A�Z�y�6'�̂)�-���2�KҴ�h���"ڨ�.�@��r�,�4B�ƙ��?���w�..���N���vt�.g��1�@����y�Q]�ۅ�DB�<J���ި�{���9��Yp)�æ�1� 'Uj@�D2����9�:|��<�Yi�vu�[c#�vc�&�ƹ�"q�Gs�Xޜ|]0�z�	lR� d�Kq󴅂h�q?汼�}��1�9�t�NBS�G��j���0	*��ޥm�1+�E�h��T;�Q�hg�E3&�8�~�ӂ��p'{.?cV��a�L��1�$ӆ���f�#.�����Y&��]�A�GVDn5Z�1���yC��^Ot�Θ_BS�>"4��Ō�n�u���8�.����fU/��/Oy��y4ʘ��>����<�#�G�V�Θ�<j���E1#MpÙ\5��6���M&	�C:����f�%��J40$;�n��%��&����k�B������G��ѩ8���W�Y-ycS�����ɻ�0�De�Gg�j]���
�L"N�I->��{Pm7�����˨�4}���t�H�V�9a��:�H�$�V�o<��ZԍǼ`V3 +ײxqC&�0T�"�2ƤCk�;�����a�.���t
c�^�١�Z'���6`��]>��������1����3K�hg�(���.�@����z�7���	�K����`V{K��>"A��#��#�"U��]l՛>��=����1����)r�h���a�Ԛ�!�����P�|8/�n��Y�D�?��Nio��2�S{�(�J�p!G����Y�K�F�F�u�%@d##9[Gһ�| &�΀3f�.y0�t �y��0�;"����kF���Ĵ���j48���Tj}�K��z���)<1���y�E��onJ.�e��Mz�zi=ϗ��̻^|�K�i��{-ߣȧ�e��3������o���/�K7B���:��|�.`0%7�iκ�1`@���ϼ�<ZpR�]��`v���s�X�c�U~��kŷ�ن�_�$!�m��1N=8�z;����U8�
9�}�AZ��_���a�n.	!FЖJ3���x�*�����Rf}��F��Q<`Μ��Ӈ��?��Nɏ!y�ߏy�G�0>H����K�ӷ�����>��׭�\!���>C1	�\�<���Ȯ{�rLj���Re;wD����f�)�:`��C�ˢ��@�s�F���{��j�;J'Ȯ�R�N鹄���f��j�8�wx�2�Ħ������tX�;��̾�_j��l��`T_�����2�1��s�c4q��ޝ3��}hlm4^�D����fÉ��H��4��Ф�1����2���8��)��/�`6�2�i�g���Ɇ���M�֚M�ō�*<g�l�9s����7��/W2�     