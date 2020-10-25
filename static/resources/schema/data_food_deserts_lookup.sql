-- Table: public.data_food_deserts_lookup

-- DROP TABLE public.data_food_deserts_lookup;

CREATE TABLE public.data_food_deserts_lookup
(
    "LongName" character(500) COLLATE pg_catalog."default",
    field character(500) COLLATE pg_catalog."default",
    "Description" character(500) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE public.data_food_deserts_lookup
    OWNER to postgres;

    