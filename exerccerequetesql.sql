/*1*/

	SELECT 
recipe.recipe_name,
category.category_name,
recipe.preparation_time
	FROM 
recipe
	INNER JOIN 
category ON recipe.id_category = category.id_category
	ORDER BY 
recipe.preparation_time DESC;
	
	/*2*/
	
	SELECT 
    recipe.recipe_name,
    category.category_name,
    recipe.preparation_time,
    COUNT(quantity.id_ingredient) AS nombre_ingredients
	FROM 
    recipe
	INNER JOIN 
    category ON recipe.id_category = category.id_category
	INNER JOIN 
    quantity ON recipe.id_recipe = quantity.id_recipe
	GROUP BY 
    recipe.id_recipe, recipe.recipe_name, category.category_name, recipe.preparation_time
	ORDER BY 
    recipe.preparation_time DESC;
	
	/*3*/
	
	SELECT 
    recipe.recipe_name,
    category.category_name,
    recipe.preparation_time
	FROM 
    recipe
	INNER JOIN 
    category ON recipe.id_category = category.id_category
	WHERE 
    recipe.preparation_time >= 30
	ORDER BY 
    recipe.preparation_time DESC;


/*4*/
	SELECT 
    recipe_name
	FROM 
    recipe
	WHERE 
    recipe_name LIKE '%Salade%'
	ORDER BY 
    recipe_name;
	
	/*5*/
	INSERT INTO recipe (recipe_name, id_category, preparation_time, instructions)
	VALUES ('Pâtes à la carbonara', 2, 20, 'Lorem Ipsum');

	/*ingrédients*/
	INSERT INTO ingredient VALUES (27,'Parmesan', 'g',0.49); 
	
	/*6*/
	UPDATE recipe SET recipe_name = 'Tarte aux pommes maison' WHERE id_recipe = 3; 
	
	/*7*/
	supprimer les liens clés étrangères + la recette numéro 2
	DELETE FROM quantity
    WHERE id_recipe = 2;

	DELETE FROM recipe
	WHERE id_recipe = 2;

/*8*/
	SELECT recipe.recipe_name, SUM(ingredient.price ) AS prix_total 
	FROM recipe 
	INNER JOIN quantity ON recipe.id_recipe = quantity.id_recipe 
	INNER JOIN ingredient ON quantity.id_ingredient = ingredient.id_ingredient 
	WHERE recipe.id_recipe = 5; 

/*9*/
	SELECT recipe.recipe_name, ingredient.ingredient_name, quantity.quantity, ingredient.price 
	FROM recipe JOIN quantity ON recipe.id_recipe = quantity.id_recipe 
	INNER JOIN ingredient ON quantity.id_ingredient = ingredient.id_ingredient 
	WHERE recipe.id_recipe = 5;  

/*10*/
	INSERT INTO ingredient VALUES (28,'poivre', 'cuillère à café',2.50); 

/*11*/
	UPDATE recipe.ingredient SET price = 1.99 WHERE id_ingredient = 12; 

/*12*/

	SELECT category.category_name, COUNT(recipe.id_recipe) AS Nombre_de_recettes 
	FROM recipe.category 
	INNER JOIN recipe.recipe ON category.id_category = recipe.id_category 
	GROUP BY category.category_name; 

/*13*/
	SELECT recipe.recipe_name 
	FROM recipe.recipe JOIN recipe.quantity ON recipe.id_recipe = quantity.id_recipe 
	INNER JOIN recipe.ingredient ON quantity.id_ingredient = ingredient.id_ingredient 
	WHERE ingredient.ingredient_name = 'Poulet'; 

/*14*/
UPDATE recipe.recipe SET preparation_time = preparation_time - 5; 

/*15*/
	SELECT recipe.recipe_name 
	FROM recipe.recipe 
	WHERE recipe.id_recipe NOT IN ( SELECT quantity.id_recipe 
	FROM recipe.quantity INNER JOIN recipe.ingredient ON quantity.id_ingredient = ingredient.id_ingredient 
	WHERE ingredient.price > 2 ); 

/*16*/
	SELECT recipe.recipe_name, recipe.preparation_time 
	FROM recipe.recipe 
	WHERE recipe.preparation_time = ( SELECT MIN(preparation_time) FROM recipe.recipe ); 

/*17*/
	SELECT recipe.recipe_name 
	FROM recipe.recipe LEFT JOIN recipe.quantity ON recipe.id_recipe = quantity.id_recipe 
	WHERE quantity.id_recipe IS NULL; 

/*18*/
	SELECT ingredient.ingredient_name, COUNT(quantity.id_recipe) AS Nombre_de_recettes 
	FROM recipe.ingredient 
	INNER JOIN recipe.quantity ON ingredient.id_ingredient = quantity.id_ingredient 
	GROUP BY ingredient.ingredient_name 
	HAVING COUNT(quantity.id_recipe) >= 3; 

/*19*/
ajouter ingrédient:
INSERT INTO recipe.ingredient (ingredient_name, unity, price) VALUES ('Chocolat Noir', 'g', 5.50); 
lier à la recette:
INSERT INTO recipe.quantity (quantity, id_ingredient, id_recipe) VALUES (200, 29, 4); 

/*20*/
SELECT
    recipe.recipe_name,
    SUM(quantity.quantity * ingredient.price) AS Cout_Total
	FROM
    recipe.recipe
	INNER JOIN recipe.quantity ON recipe.id_recipe = quantity.id_recipe
	INNER JOIN recipe.ingredient ON quantity.id_ingredient = ingredient.id_ingredient
	GROUP BY recipe.id_recipe, recipe.recipe_name
	HAVING SUM(quantity.quantity * ingredient.price) = (
        SELECT MAX(Total_Cost)
        FROM (
            SELECT
                SUM(quantity.quantity * ingredient.price) AS Total_Cost
            FROM
                recipe.recipe
            INNER JOIN
                recipe.quantity ON recipe.id_recipe = quantity.id_recipe
            INNER JOIN
                recipe.ingredient ON quantity.id_ingredient = ingredient.id_ingredient
            GROUP BY
                recipe.id_recipe
        ) AS Recette_Couts
    );
	
	