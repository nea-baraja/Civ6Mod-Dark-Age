insert into TraitModifiers(TraitType,   ModifierId) select
    '你的trait',     Value
    from ModifierArguments where ModifierId like '%UNIQUE_INFLUENCE%' and Name = 'ModifierId';